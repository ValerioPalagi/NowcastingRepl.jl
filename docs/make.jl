using Documenter
using NowcastingRepl

makedocs(
    sitename = "NowcastingRepl",
    format = Documenter.HTML(),
    modules = [NowcastingRepl]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
