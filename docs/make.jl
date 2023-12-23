using ChasteDatFileToCSV
using Documenter

DocMeta.setdocmeta!(ChasteDatFileToCSV, :DocTestSetup, :(using ChasteDatFileToCSV); recursive=true)

makedocs(;
    modules=[ChasteDatFileToCSV],
    authors="Jonathan Miller",
    repo="https://github.com/fieldofnodes/ChasteDatFileToCSV.jl/blob/{commit}{path}#{line}",
    sitename="ChasteDatFileToCSV.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://fieldofnodes.github.io/ChasteDatFileToCSV.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/fieldofnodes/ChasteDatFileToCSV.jl",
    devbranch="main",
)
