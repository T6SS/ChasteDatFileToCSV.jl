# ChasteDatFileToCSV

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://fieldofnodes.github.io/ChasteDatFileToCSV.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://fieldofnodes.github.io/ChasteDatFileToCSV.jl/dev/)
[![Build Status](https://github.com/fieldofnodes/ChasteDatFileToCSV.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/fieldofnodes/ChasteDatFileToCSV.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Build Status](https://travis-ci.com/fieldofnodes/ChasteDatFileToCSV.jl.svg?branch=main)](https://travis-ci.com/fieldofnodes/ChasteDatFileToCSV.jl)
[![Coverage](https://codecov.io/gh/fieldofnodes/ChasteDatFileToCSV.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/fieldofnodes/ChasteDatFileToCSV.jl)


# Chaste data outputs

Chaste (at least in Cell-Based) outputs `.dat` files. Each line is the time and information regarding the cell is printed to screen.

This repository (still being worked on) takes an arbitrary `.dat` file, along with the corresponding type, and non-time columns and outputs a csv.

