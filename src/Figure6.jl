using CSV, DataFrames, Dates, Plots, AdvancedMH, Distributions, StatsFuns, Random, LinearAlgebra
include("Functions_try.jl")

# Load data
data_us = CSV.read("./Data/Data_US.csv", DataFrame; dateformat="m/d/Y H:M")
data_ea = CSV.read("./Data/Data_EA.csv", DataFrame; dateformat="m/d/Y H:M")

start_pos = 1

# Extract Y and convert to Int vector (0/1)
Y = Int.(data_us[start_pos:end, :NBER_Recession])

# Extract predictors matrix
pmi_manuf = data_us[start_pos:end, :PMI_Manuf]

# Create the design matrix with intercept and CISS
X_macro = hcat(ones(length(pmi_manuf)), pmi_manuf)


# Run the Bayesian logistic regression
pi_median_macro, beta_samples_macro = bayesian_logit(Y, X_macro; n_iter=250000, prior_var=10.0, step_size=0.05)

#println("Posterior median of pi:")
#println(pi_median)

# Plot the posterior median of pi as percentages
# Extract the relevant dates
plot_dates = data_ea.Date[1:end]

# Format the x-ticks to show only the year
xticks = (plot_dates[1:12:end], Dates.format.(plot_dates[1:12:end], dateformat"yyyy"))

# Extract the relevant dates
plot_dates = data_ea.Date[1:end]

# Create xticks every 5 years
tick_indices = 1:60:length(plot_dates)
xtick_dates = plot_dates[tick_indices]
xtick_labels = Dates.format.(xtick_dates, dateformat"yyyy")

# Extract the relevant dates and values
plot_dates = data_ea.Date[1:end]
plot_values_macro = vec(pi_median_macro) .* 100

# Create xticks every 5 years (assuming monthly data) 
tick_indices = 1:60:length(plot_dates)
xtick_dates = plot_dates[tick_indices]
xtick_labels = Dates.format.(xtick_dates, dateformat"yyyy")

# For confidence bands


pi_median_macro, beta_samples_macro = bayesian_logit(Y, X_macro; n_iter=250000, prior_var=10.0, step_size=0.05)

# Recalculate pi_samples from beta_samples
pi_samples_macro = logistic.(X_macro * beta_samples_macro)

# Compute credible intervals
pi_lower_macro, pi_upper_macro = pi_credible_interval(pi_samples_macro)
# Add grey vertical shaded regions for recession periods

pi_mid_macro = (vec(pi_upper_macro) .+ vec(pi_lower_macro)) ./ 2 .* 100

ribbon_halfwidth_macro = (vec(pi_upper_macro) .- vec(pi_lower_macro)) ./ 2 .* 100


# Computation for FINANCIAL
ciss = data_us[start_pos:end, :CISS]
X_fin = hcat(ones(length(ciss)), ciss)
# Run the Bayesian logistic regression
pi_median_fin, beta_samples_fin = bayesian_logit(Y, X_fin; n_iter=250000, prior_var=10.0, step_size=0.05)
plot_values_fin = vec(pi_median_fin) .* 100

# Confidence bands
pi_median_fin, beta_samples_fin = bayesian_logit(Y, X_fin; n_iter=250000, prior_var=10.0, step_size=0.05)

# Recalculate pi_samples from beta_samples
pi_samples_fin = logistic.(X_fin * beta_samples_fin)

# Compute credible intervals
pi_lower_fin, pi_upper_fin = pi_credible_interval(pi_samples_fin)
# Add grey vertical shaded regions for recession periods

pi_mid_fin = (vec(pi_upper_fin) .+ vec(pi_lower_fin)) ./ 2 .* 100

ribbon_halfwidth_fin = (vec(pi_upper_fin) .- vec(pi_lower_fin)) ./ 2 .* 100


# Plot median (already done before) for MACRO
plt = plot(plot_dates, plot_values_macro,
    xlabel = "Date",
    ylabel = "Recession Risk (%)",
    title = "United States",
    color = :orange,
    label = "Macro",
    legend = true,
    lw = 2,
    size = (800, 600),
    xticks = (xtick_dates, xtick_labels))




# Add correct blue shaded credible interval
plot!(plot_dates, pi_mid_macro,
    ribbon = ribbon_halfwidth_macro,
    fillalpha = 0.25,
    color = :orange,
    lw = 0,  # no line
    label = "")

plot!(plot_dates, plot_values_fin,
    color = :green,
    label = "Financial",
    lw = 2)

plot!(plot_dates, pi_mid_fin,
    ribbon = ribbon_halfwidth_fin,
    fillalpha = 0.25,
    color = :green,
    lw = 0,  # no line
    label = "")

recession_dates = data_us[!, :Date][data_us[!, :NBER_Recession] .== 1]

for d in recession_dates
    vline!([d], color = :black, lw = 1, alpha = 0.2, label = "")
end

mkpath("./Output")
savefig(plt, "./Output/Figure_6.png")