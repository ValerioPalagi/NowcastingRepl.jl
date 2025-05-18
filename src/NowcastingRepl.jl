module NowcastingRepl

# NOWCASTING RECESSION RISK
# Francesco Furno and Domenico Giannone
# Replication on Julia by Valerio Palagi and Isotta Valpreda

# Note: Ensure Nowcasting is already in your Julia environment
using Nowcasting

# Load custom functions and data utilities
include("Subfunctions/loader.jl")  # optional, for helper functions
include("Data/loader.jl")          # optional, for data utilities


# === Main figures and tables ===
include("scripts/Figure1.jl")
include("scripts/Figure2367A3.jl")

end
