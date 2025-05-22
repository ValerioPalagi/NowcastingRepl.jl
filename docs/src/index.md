# NowcastingRepl.jl

Documentation for NowcastingRepl.jl

# NowcastingRepl.jl Documentation

**NowcastingRepl.jl** is a Julia package that replicates the main results from the 2024 paper [_Nowcasting Recession Risk_](https://assets.amazon.science/12/ce/ceca29ba49ecae3b6367041fbf11/nowcasting-recession-risk.pdf) by Domenico Giannone and Francesco Furno.

The original codebase was developed in MATLAB. This project reproduces its core logic in Julia, focusing on replicating the results from **Sections 2.3 and 2.4**, and generating **Figures 1, 3, 6** and **Table 4 (Overall results)** of the paper.

This work is part of a [*Structural Econometrics*](https://floswald.github.io/CompEcon/) course project by first-year PhD students at Collegio Carlo Alberto & University of Turin.

**Authors**: Valerio Palagi & Isotta Valpreda

---

## Package Overview

This package implements:

- Bayesian logit models for nowcasting recession risk
- Accuracy assessment thropugh the computation of the (overall) Brier Score

---

## Reproduction Instructions

To reproduce the results:

1. Clone the repository:
   ```bash
   git clone https://github.com/ValerioPalagi/NowcastingRepl.jl.git
   cd NowcastingRepl.jl
   julia

2. In the Julia REPL, activate the environment and instantiate dependencies:
    ```bash
    ] activate .
    ] instantiate
    ```
**Required packages:**
- CSV
- DataFrames
- Dates
- Plots
- AdvancedMH
- Distributions
- StatsFuns
- Random
- LinearAlgebra
- Statistics

## Package structure
```bash
NowcastingRepl.jl/
├── Data/                   # Raw input data
├── Output/                 # Replication results
│   ├── Figure_1.png
│   ├── Figure_3.1.png
│   ├── Figure_3.2.png
│   ├── Figure_6.png
│   └── Table_4_Overall.png
├── docs/                   # Documentation
├── src/                    # Source code
│   ├── NowcastingRepl.jl
│   ├── Figure1.jl
│   ├── Figure3.1.jl
│   ├── Figure3.2.jl
│   ├── Figure6.jl
│   ├── Table4_Overall.jl
│   └── Functions_try.jl
├── test/                   # Unit tests
│   ├── runtests.jl
│   └── Functions_try.jl
├── Project.toml            # Environment configuration
└── README.md
```

## Technical notes:
While the replication closely follows the methodology of the original authors, some discrepancies—particularly in Brier Score values—have been observed. This divergence is likely due to differences in the implementation of the Bayesian_logit function.

- The original MATLAB version employs a slice sampling algorithm.
- Our Julia version implements a direct Bayesian logit specification without slicing.
  
This approximation may slightly impact probabilistic forecast metrics but does not alter the qualitative conclusions of the paper.

## Disclaimer

This repository is intended for academic replication and educational purposes only. If you use or build upon this work, please cite the original paper:

Giannone, D., & Furno, F. (2024). Nowcasting Recession Risk. Amazon Science.
