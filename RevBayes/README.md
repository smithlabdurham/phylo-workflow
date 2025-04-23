# Bayesian analysis

Bayesian inference of tree topology using RevBayes.

RevBayes provides an alternative to MrBayes for Bayesian Inference.
RevBayes has a powerful scripting language that allows precise specification of
sophisticated models.


## Download RevBayes

- [Install](https://revbayes.github.io/download) the latest release of RevBayes for your platform.

- Copy the executable file (e.g. `revbayes/build/rb.exe` on Windows) to this directory.

## Download matrix

- Place a copy of the matrix for analysis, in NEXUS format, in this directory.
- Ensure the matrix does not contain an `ASSUMPTIONS` block ([Issue #732](https://github.com/revbayes/revbayes/issues/732)).
- If a `STATELABELS` block exists, ensure it terminates with a comma ([Issue #731](https://github.com/revbayes/revbayes/issues/731)) – or delete it.


## Modify analytical script

- Open `MkInf.Rev` in your favourite text editor (e.g.
[Notepad++](https://notepad-plus-plus.org/downloads/))

- You may find it helpful to enable syntax highlighting.  In Notepad++, 
  select "Language→R→R".
  
- Review and adjust the settings at the top of the script.  In particular, you
  will need to replace `inputFile = "data.nex"` with the name of your character matrix file.


## Run the analysis

Launch RevBayes (by double-clicking the executable?) and type
`source("MkInf.Rev")`.  Press enter to begin the analysis.

- Or, on Windows, launch the command prompt by typing `cmd` into the start menu; navigate to this directory
  (using `cd ../path/to/directory`), then launch RevBayes with e.g. `rb.exe MkInf.Rev`.


# Default script

`MkInf.Rev` performs analysis as described below.
(`Mkv.Rev` conditions on observing variable, rather than parsimony-informative, characters.)
You are welcome to adapt this text to describe your use of the model in publications.

Each character is assigned to a partition _partition-k_, where
_k_ denotes the number of unique states observed for that character.
Each such partition is analysed under a symmetric Markov _k_-state model
(Lewis 2001) conditioned on observing only parsimony-informative sites.
Between-character rate heterogeneity is modelled using a log-normal distribution
with arithmetic mean 1 (Wagner 2012; Harrison and Larsson 2015) discretized into
six rate categories (Wright and Wynd 2024).
Within partitions, we model between-site rate variation with a log-normal
distribution (Wagner 2012) discretized into six categories (Wright and Wynd 2024).
We use a uniform prior on tree topologies, and a compound dirichlet prior on
edge length variability (Zhang, Rannala and Yang 2012), with a prior
expectation of one change per site.
Each analysis is conducted in RevBayes v1.2 (Höhna et al. 2016) using two
Metropolis-coupled Monte Carlo Markov runs of eight chains each.
Before sampling begins, we perform 500 generations in order to tune move
proposals.
(Each generation comprises a number of proposals that is proportional to the
complexity of the analysis.)
After this tuning phase, each analysis continues until the effective sample size
(ESS) exceeds 256 for each parameter, yielding a precision of < 1.11%
(Fabreti and Höhna 2022).

> We estimate the ESS of tree topologies using the lower of
> the Frechet Correlation and Median PseudoESS measures
> (Lanfear, Hua and Warren 2016; Magee et al. 2024).
> (This is not yet implemented in this workflow.)

> To ensure that our sample corresponds to the posterior distribution, we then
> discard a number of generations as burn-in.
> For each analysis, we discard the number of burn-in generations that maximizes
> the effective sample size, subject to a potential scale reduction factor below
> 1.02 (Gelman and Rubin 1992; Vats and Knudson 2021).
> (This step is not yet implemented in this workflow.)


# References

* Fabreti LG, Höhna S. Convergence assessment for Bayesian phylogenetic analysis using MCMC simulation. Methods in Ecology and Evolution 2022;13:77–90.
* Gelman A, Rubin DB. Inference from iterative simulation using multiple sequences. Statistical Science 1992;7:457–72.
* Harrison LB, Larsson HCE. Among-Character Rate Variation Distributions in Phylogenetic Analysis of Discrete Morphological Characters. Systematic Biology 2015;64:307–24.
* Höhna S, Landis MJ, Heath TA et al. RevBayes: Bayesian phylogenetic inference using graphical models and an interactive model-specification language. Syst Biol 2016;65:726–36.
* Lanfear R, Hua X, Warren DL. Estimating the effective sample size of tree topologies from Bayesian phylogenetic analyses. Genome Biology and Evolution 2016;8:2319–32.
* Lewis PO. A likelihood approach to estimating phylogeny from discrete morphological character data. Systematic Biology 2001;50:913–25.
* Magee A, Karcher M, Matsen FA et al. How trustworthy is your tree? Bayesian phylogenetic effective sample size through the lens of Monte Carlo error. Bayesian Analysis 2024;19:565–93.
* Vats D, Knudson C. Revisiting the Gelman–Rubin diagnostic. Statistical Science 2021;36:518–29.
* Wagner PJ. Modelling rate distributions using character compatibility: implications for morphological evolution among fossil invertebrates. Biology Letters 2012;8:143–6.
* Wright AM, Wynd BM. Modeling of rate heterogeneity in datasets compiled for use with parsimony. 2024, DOI: 10.1101/2024.06.26.600858.
* Zhang C, Rannala B, Yang Z. Robustness of compound Dirichlet priors for Bayesian inference of branch lengths. Systematic Biology 2012;61:779–84.
