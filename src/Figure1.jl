using CSV, DataFrames, Plots

# Define colors as hex strings directly
Color1 = "#0072BD"
Color2 = "#D95319"

# Load data
data_us = CSV.read("./Data/Data_US.csv", DataFrame; dateformat="m/d/y H:M")
data_ea = CSV.read("./Data/Data_EA.csv", DataFrame; dateformat="m/d/y H:M")

# Logical indexes
index_recession_us = data_us.NBER_Recession .== 1
index_expansion_us = .!index_recession_us

index_recession_ea = data_ea.CEPR_Recession .== 1
index_expansion_ea = .!index_recession_ea

# Plot US
plot1 = scatter(
    data_us.CISS[index_recession_us], data_us.PMI_Manuf[index_recession_us],
    label = "Recessions", markersize = 4, color = Color1,
)
scatter!(
    data_us.CISS[index_expansion_us], data_us.PMI_Manuf[index_expansion_us],
    label = "Expansions", markersize = 4, color = Color2,
)
xlabel!("Financial (CISS)")
ylabel!("Macro (PMI)")
title!("United States")

# Plot EA
plot2 = scatter(
    data_ea.CISS[index_recession_ea], data_ea.ESI[index_recession_ea],
    label = "Recessions", markersize = 4, color = Color1,
)
scatter!(
    data_ea.CISS[index_expansion_ea], data_ea.ESI[index_expansion_ea],
    label = "Expansions", markersize = 4, color = Color2,
)
xlabel!("Financial (CISS)")
ylabel!("Macro (ESI)")
title!("Euro Area")

# Combine and save
fig = plot(plot1, plot2, layout = (1, 2), size = (1017, 403), legend = :bottomright, background_color = :white)

# Make sure output folder exists, then save
mkpath("./Output")
savefig(fig, "./Output/Figure_1.png")
