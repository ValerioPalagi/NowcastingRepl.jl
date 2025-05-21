# Definition of the logistic function
logistic(x) = 1 / (1 + exp(-x))


# Function to perform Bayesian logistic regression 
function bayesian_logit(Y::Vector{Int}, X::Matrix; n_iter=10000, prior_var=10.0, step_size=0.1)
    n, p = size(X)
    prior = MvNormal(zeros(p), prior_var * Matrix(I, p, p))
    function log_posterior(beta)
        η = X * beta
        pi = logistic.(η)
        pi = clamp.(pi, 1e-9, 1-1e-9)
        log_lik = sum(Y .* log.(pi) + (1 .- Y) .* log.(1 .- pi))
        log_prior = logpdf(prior, beta)
        return log_lik + log_prior
    end
    beta = zeros(p)
    samples = zeros(p, n_iter)
    current_lp = log_posterior(beta)
    for i in 1:n_iter
        beta_prop = beta + step_size * randn(p)
        prop_lp = log_posterior(beta_prop)
        if log(rand()) < prop_lp - current_lp
            beta = beta_prop
            current_lp = prop_lp
        end
        samples[:, i] = beta
    end
    pi_samples = logistic.(X * samples)
    pi_post_median = mapslices(median, pi_samples; dims=2)
    return pi_post_median, samples
end

function pi_credible_interval(pi_samples::Matrix)
    lower = mapslices(x -> quantile(x, 0.05), pi_samples; dims=2)
    upper = mapslices(x -> quantile(x, 0.95), pi_samples; dims=2)
    return lower, upper
end