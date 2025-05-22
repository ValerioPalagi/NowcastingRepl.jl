#using Documenter
#using NowcastingRepl

#makedocs(
 #   sitename = "NowcastingRepl.jl",
  #  modules = [NowcastingRepl],
   # format = Documenter.HTML(),
    #pages = [
     #   "Home" => "index.md",
    #],
    #repo = "https://github.com/ValerioPalagi/NowcastingRepl.jl",
    #authors = "Valerio Palagi, Isotta Valpreda"
#)
using NowcastingRepl
using Documenter

DocMeta.setdocmeta!(NowcastingRepl, :DocTestSetup, :(using NowcastingRepl); recursive=true)

makedocs(;
    modules=[NowcastingRepl],
    authors="Valerio Palagi, Isotta Valpreda",
    sitename="NowcastingRepl.jl",
    format=Documenter.HTML(;
        canonical="https://github.com/ValerioPalagi/NowcastingRepl.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
