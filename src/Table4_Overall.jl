using CSV, DataFrames, Dates, Plots, AdvancedMH, Distributions, StatsFuns, Random, LinearAlgebra
using Printf
include("Functions_try.jl")

# Load data
data_us = CSV.read("./Data/Data_US.csv", DataFrame; dateformat="m/d/Y H:M")
data_ea = CSV.read("./Data/Data_EA.csv", DataFrame; dateformat="m/d/Y H:M")

start_pos_us = 1
start_pos_ea = 62
# Extract Y and convert to Int vector (0/1)
Y_us = Int.(data_us[start_pos_us:end, :NBER_Recession])
Y_ea = Int.(data_ea[start_pos_ea:end, :CEPR_Recession])
# Extract predictors matrix
X_us = hcat(ones(size(data_us[start_pos_us:end, :PMI_Manuf], 1)), Matrix(data_us[start_pos_us:end, [:PMI_Manuf, :CISS]]))
X_ea = hcat(ones(size(data_ea[start_pos_ea:end, :CISS], 1)), Matrix(data_ea[start_pos_ea:end, [:CISS, :ESI]]))

# Run the Bayesian logistic regression
pi_median_us, beta_samples_us = bayesian_logit(Y_us, X_us; n_iter=250000, prior_var=10.0, step_size=0.05)
pi_median_ea, beta_samples_ea = bayesian_logit(Y_ea, X_ea; n_iter=250000, prior_var=10.0, step_size=0.05)


BrierScore_us = sum((pi_median_us .- Y_us).^2) / length(pi_median_us)
println("Brier Score US ", BrierScore_us)
BrierScore_ea = sum((pi_median_ea .- Y_ea).^2) / length(pi_median_ea)
println("Brier Score EA ", BrierScore_ea)

# ---------- US: PMI_Manuf ----------
X_us_pmi = hcat(ones(length(Y_us)), data_us[start_pos_us:end, :PMI_Manuf])
pi_median_us_pmi, beta_samples_us_pmi = bayesian_logit(Y_us, X_us_pmi; n_iter=250000, prior_var=10.0, step_size=0.05)
brier_us_pmi = sum((pi_median_us_pmi .- Y_us).^2) / length(pi_median_us_pmi)

# ---------- US: CISS ----------
X_us_ciss = hcat(ones(length(Y_us)), data_us[start_pos_us:end, :CISS])
pi_median_us_ciss, beta_samples_us_ciss = bayesian_logit(Y_us, X_us_ciss; n_iter=250000, prior_var=10.0, step_size=0.05)
brier_us_ciss = sum((pi_median_us_ciss .- Y_us).^2) / length(pi_median_us_ciss)

# ---------- EA: CISS ----------
X_ea_ciss = hcat(ones(length(Y_ea)), data_ea[start_pos_ea:end, :CISS])
pi_median_ea_ciss, beta_samples_ea_ciss = bayesian_logit(Y_ea, X_ea_ciss; n_iter=250000, prior_var=10.0, step_size=0.05)
brier_ea_ciss = sum((pi_median_ea_ciss .- Y_ea).^2) / length(pi_median_ea_ciss)

# ---------- EA: ESI ----------
X_ea_esi = hcat(ones(length(Y_ea)), data_ea[start_pos_ea:end, :ESI])
pi_median_ea_esi, beta_samples_ea_esi = bayesian_logit(Y_ea, X_ea_esi; n_iter=250000, prior_var=10.0, step_size=0.05)
brier_ea_esi = sum((pi_median_ea_esi .- Y_ea).^2) / length(pi_median_ea_esi)


println("Brier Score ea esi ", brier_ea_esi)
println("Brier Score us pmi ", brier_us_pmi)
println("Brier Score us ciss ", brier_us_ciss)
println("Brier Score ea ciss ", brier_ea_ciss)