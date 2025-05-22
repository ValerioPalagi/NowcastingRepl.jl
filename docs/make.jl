using Documenter
using NowcastingRepl

makedocs(
    sitename = "NowcastingRepl.jl",
    modules = [NowcastingRepl],
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
    ],
    repo = "https://github.com/ValerioPalagi/NowcastingRepl.jl",
    authors = ["Valerio Palagi", "Isotta Valpreda"]
)
