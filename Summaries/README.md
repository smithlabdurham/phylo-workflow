# Summarizing results

Scripts in this folder will produce visual summaries of the phylogenetic results
computed in the `TreeSearch`, `MrBayes` and `TNT` folders of this repository.

Make sure you have completed these analyses first, following the steps in the
`README.md` file of each directory.

These scripts are not yet thoroughly road-tested.  If (when?) you encounter
any difficulties, please [Create a GitHub issue](
https://github.com/smithlabdurham/phylo-workflow/issues/new)
or start a [discussion](
https://github.com/smithlabdurham/phylo-workflow/discussions).

We recommend opening `Summarize.Rproj` in RStudio to run these scripts.


## Tree summaries

`Plot-Trees.R` creates a PDF file containing consensus trees of TreeSearch and
MrBayes results.
(TNT trees are not yet supported – if this would be useful, please
 [Create a GitHub issue](
https://github.com/smithlabdurham/phylo-workflow/issues/new))

Rogue taxa will be removed from the consensus trees to maximise the information
content of the displayed trees, following Smith
([2022](https://doi.org/10.1093/sysbio/syab099)).

Open the file in RStudio, check the variables listed at the top of the script,
and click 'Source' to run the entire script.  This will create a file
`Tree-summary.pdf`.

## Analysis overview

`map_trees.Rmd` creates a PDF document containing:

- A majority rule consensus of Bayesian trees, with posterior split probabilities;
- A strict consensus of implied weight trees under different concavity constants
  (which will likely be usefully adapted to your own results), with quartet
  concordance as a measure of split support;
- A cluster analysis, presenting majority consensus trees for distinct clusters
  of trees (note that frequency of parsimonious trees is not correlated to
  support - interpret these with care);
- A two-dimensional mapping of tree space, showing the relationship between
  Bayesian and parsimony results
- A higher-dimensional mapping of tree space giving a more complete picture 
  of the spatial relationships between trees.

  
Rogue taxa are omitted from consensus trees to maximise the information
displayed.

### Running the script

To execute the script, open it in RStudio and click the "Knit" button at the 
top of the editor window (Windows shortcut: <kbd>Shift-Ctrl-K<kbd>).
This will attempt to create a PDF file `map_trees.pdf`.


### Adapting the script

This file has been adapted from that used to create supplementary information
files in Smith, Long _et al._ [2024](https://doi.org/10.1038/s41586-024-07756-8)
and has not yet been thoroughly generalized to work automatically with other
datasets.  You may need to modify the script to work with your data.
If you need help getting the script to run with your data, please
[open a GitHub issue](
https://github.com/smithlabdurham/phylo-workflow/issues/new).

You are encouraged to incorporate the text in the document, modified as 
appropriate, into supplementary information files to accompany phylogenetic
results.

The format of the output file can be configured using the YAML header,
and the additional `_bookdown.yml` file; as distributed, this file causes the
figures to be labelled as 'Supplementary Figure N' in the rendered output.
