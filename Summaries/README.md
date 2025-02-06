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

