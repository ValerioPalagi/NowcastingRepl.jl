module NowcastingRepl

using CSV, DataFrames, Dates, Plots, AdvancedMH, Distributions, StatsFuns, Random, LinearAlgebra, Statistics

function run()
    include("src/Functions_try.jl")
    include("src/Figure_1.jl")
    include("src/Figure_3.1.jl")
    include("src/Figure_3.2.jl")
    include("src/Figure_6.jl")
    include("src/Table_4_Overall.jl")
end 

export run
end