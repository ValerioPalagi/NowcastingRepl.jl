module NowcastingRepl

using CSV, DataFrames, Plots

function run()
    include("src/Functions.jl")
    include("src/Figure1.jl")
   
end 

export run
end