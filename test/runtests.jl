using NowcastingRepl
using Test,CSV, DataFrames, Dates, Plots, AdvancedMH, Distributions, StatsFuns, Random, LinearAlgebra

logistic(x) = 1 / (1 + exp(-x))

include("Functions_try.jl")


@testset "NowcastingRepl.jl" begin
    @testset "Basic logistic function tests" begin
    @test isapprox(logistic(0), 0.5; atol=1e-6)
    @test logistic(100) ≈ 1.0
    @test logistic(-10000) ≈ 0.0
end
        Y = [0, 1, 0, 1]
        X = [1 0.5; 1 1.5; 1 -0.5; 1 -1.5]
@testset "Bayesian logistic regression tests" begin
        
        # Run the Bayesian logistic regression
        pi_median, beta_samples = bayesian_logit(Y, X; n_iter=1000, prior_var=10.0, step_size=0.05)
        
        # Check the dimensions of the output
        @test size(pi_median) == (4,1)
        @test size(beta_samples) == (2, 1000)
end

@testset "Credible interval tests" begin
        
        # Run the Bayesian logistic regression
        pi_median, beta_samples = bayesian_logit(Y, X; n_iter=1000, prior_var=10.0, step_size=0.05)
        
        # Recalculate pi_samples from beta_samples
        pi_samples = logistic.(X * beta_samples)
        
        # Compute credible intervals
        pi_lower, pi_upper = pi_credible_interval(pi_samples)
        
        # Check the dimensions of the output
        @test size(pi_lower) == (4,1)
        @test size(pi_upper) == (4,1)
    end
end