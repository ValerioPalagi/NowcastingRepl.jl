module NowcastingRepl

using CSV, DataFrames, Plots, Distributions, StatsFuns, Random, AdvancedMH

function run()
    include("src/Functions.jl")
    include("src/Figure1.jl")
   
end 

export run
end