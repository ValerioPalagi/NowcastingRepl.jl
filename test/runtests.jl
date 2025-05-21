using NowcastingRepl
using Test, CSV, DataFrames

logistic(x) = 1 / (1 + exp(-x))
data_us = CSV.read("./test/Data_US.csv", DataFrame; dateformat="m/d/y H:M")
data_ea = CSV.read("./test/Data_EA.csv", DataFrame; dateformat="m/d/y H:M")


@testset "NowcastingRepl.jl" begin
    @testset "Basic logistic function tests" begin
    @test isapprox(logistic(0), 0.5; atol=1e-6)
    @test logistic(100) ≈ 1.0
    @test logistic(-10000) ≈ 0.0
end

@testset "Recession series validity" begin
        @test all(x -> x in (0, 1), data_us.NBER_Recession)
        @test all(x -> x in (0, 1), data_ea.CEPR_Recession[62:end])
end
end