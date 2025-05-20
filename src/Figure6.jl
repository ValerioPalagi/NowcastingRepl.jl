using CSV, DataFrames, Dates, Plots, AdvancedMH, Distributions, StatsFuns, Random, LinearAlgebra, Statistics
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
X = hcat(ones(length(ciss)), pmi_manuf)


# Run the Bayesian logistic regression
pi_median, beta_samples = bayesian_logit(Y, X; n_iter=250000, prior_var=10.0, step_size=0.05)

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
plot_values = vec(pi_median) .* 100

# Create xticks every 5 years (assuming monthly data) 
tick_indices = 1:60:length(plot_dates)
xtick_dates = plot_dates[tick_indices]
xtick_labels = Dates.format.(xtick_dates, dateformat"yyyy")

# Create the main plot


pi_median, beta_samples = bayesian_logit(Y, X; n_iter=250000, prior_var=10.0, step_size=0.05)

# Recalculate pi_samples from beta_samples
pi_samples = logistic.(X * beta_samples)

# Compute credible intervals
pi_lower, pi_upper = pi_credible_interval(pi_samples)
# Add grey vertical shaded regions for recession periods

pi_mid = (vec(pi_upper) .+ vec(pi_lower)) ./ 2 .* 100

ribbon_halfwidth = (vec(pi_upper) .- vec(pi_lower)) ./ 2 .* 100
# Plot median (already done before)
plt = plot(plot_dates, plot_values,
    xlabel = "Date",
    ylabel = "Recession Risk (%)",
    title = "United States",
    legend = false,
    lw = 2,
    xticks = (xtick_dates, xtick_labels))

# Add correct blue shaded credible interval
plot!(plot_dates, pi_mid,
    ribbon = ribbon_halfwidth,
    fillalpha = 0.3,
    color = :blue,
    lw = 0,  # no line
    label = "")

    
display(plt)