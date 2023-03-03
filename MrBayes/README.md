# Bayesian analysis

Analysis using MrBayes

## Download MrBayes

- [Download](https://nbisweden.github.io/MrBayes/download.html) the latest release of MrBayes for your platform.

- Copy the executable file (e.g. `MrBayes/bin/mb.3.2.7-win64.exe` on Windows) to this directory.

## Download matrix

- Place a copy of the matrix for analysis, in NEXUS format, in this folder.

## Edit matrix

- Open the matrix in your favourite text editor (e.g.
[Notepad++](https://notepad-plus-plus.org/downloads/))

- The matrix file may need some editing, e.g. MrBayes does not support
 
  - quotations around taxon names
  - spaces in taxon names (replace with underscore)
 
 - Add a MrBayes block containing the details of the desired analysis to the 
   end of the file.
   Example:
   
```nexus

BEGIN MRBAYES;
  [ Configure priors ]
  lset coding=variable rates=gamma;
  prset brlenspr=unconstrained: gammadir(1, 0.35, 1, 1);
  
  [ Configure MCMC parameters ]
  mcmcp ngen=5000000 samplefreq=500 nruns=2 nchains=8 burninfrac=0.1;
  
  [ Run the analysis ]
  mcmc; 
  
END;

```

A model "real life" analysis with an explanation of parameter choices can be found at:
https://ms609.github.io/hyoliths/bayesian.html

## Run the file

Launch MrBayes (by double-clicking the executable?) and type
` exe NAME_OF_MATRIX_FILE.NEX`.  Press enter to begin the analysis.
