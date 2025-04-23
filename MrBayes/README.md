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
  - `CharLabels` or `CharStateLabels` blocks
  - Many specifications of the `Format;` command
  - Separate `Taxa` and `Characters` blocks:
    - Move the text `NTAX=1234` from the `Taxa` block, inserting it in the `Characters` block by adding to the line
      `Dimensions NCHAR=1234 <here insert: NTAX=1234>;`
    - Delete the `Taxa` block
    - Rename the `Characters` block to `Data`, i.e. replace `Begin Characters;` with `Begin Data;`
  - Ambiguous states that include the gap character, e.g. `{-,1}`.  Replace these with `?`;
  - Non-ASCII characters (as might be found in a custom `Notes` block).

  MrBayes will report anything it cannot handle; generally, aim for a parsimonious Nexus file.
  If MrBayes closes unexpectedly, taking any error messages with it, try launching it from the command line:
  
- Add a MrBayes block containing the details of the desired analysis to the 
   end of the file.
   Example:
   
```nexus

BEGIN MRBAYES;
  [ Configure priors ]
  lset coding=informative rates=gamma;
  prset brlenspr=unconstrained: gammadir(1, 0.35, 1, 1);
  
  [ Configure MCMC parameters ]
  mcmcp ngen=5000000 samplefreq=500 nruns=4 nchains=8 burninfrac=0.1;
  
  [ End run automatically ]
  set autoclose=yes;
  
  [ Run the analysis ]
  mcmc;
  
  [ Summarise results ]
  sump; [ Summarize parameters in .pstat file ]
  sumt; [ Summarize trees in .con.tree and .trprobs files ]
  
END;

```

A model "real life" analysis with an explanation of parameter choices can be found at:
https://ms609.github.io/hyoliths/bayesian.html

## Run the analysis

Launch MrBayes (by double-clicking the executable?) and type
` exe NAME_OF_MATRIX_FILE.NEX`.  Press enter to begin the analysis.

- Or, on Windows, launch the command prompt by typing `cmd` into the start menu; navigate to this directory
  (using `cd ../path/to/directory`), then launch MrBayes with e.g. `mb.3.2.7-win64.exe MyNexusFile.nex`.
