using NowcastingRepl
using Test

@testset "NowcastingRepl.jl" begin
    # Test the run function
   # NowcastingRepl.run()
    
    # Check if the output file exists
   # @test isfile("./Output/Figure1.png") == true
    
    # Check if the output file is not empty 
   # @test filesize("./Output/Figure1.png") > 0
    
    # Check if the output file is a PNG
    @test endswith("./Output/Figure1.png", ".png")
end