# Load required libraries
library("TreeTools", quietly = TRUE)
library("TreeDist")
library("TreeSearch")
library("Rogue")


# Check working directory
getwd() # Should match location of data / tree files
setwd("../TNT") # Select TNT directory - modify path if necessary
dataFile <- list.files(pattern = "mbank_.*.tnt", full.names = TRUE)[[1]]
outgroup <- c("Tubiluchus") # Specify taxa on which to root tree

# Load helper functions from TreeSearch subdirectory
source("../TreeSearch/common.R")
source("../TreeSearch/plot.R")

dataset <- ReadTntAsPhyDat(dataFile)

treeFiles <- list.files(pattern = "*.tre", full.names = TRUE)

for (treeFile in treeFiles) {
  # Load trees from file
  trees <- ReadTntTree(treeFile)
  
  # Ignore outgroup taxa that aren't in tree
  outgroup <- intersect(outgroup, TipLabels(c(trees)[[1]]))
  if (length(outgroup)) {
    # Root trees on outgroup
    trees <- RootTree(trees, outgroup)
  }
  rogues <- QuickRogue(trees, p = 1)
  cons <- ConsensusWithout(trees, rogues[-1, "taxon"])
  
  pdf(gsub(".tre", ".pdf", treeFile, fixed = TRUE), 
      width = 8, height = 10)
  
  # Set up plotting area
  par(
    mar = c(0, 0, 0, 0), # Zero margins
    cex = 0.9            # Smaller font size
  )
  # cons$edge.length <- rep.int(1L, nrow(cons$edge))
  
  # Plot consensus tree
  tipCols <- Rogue::ColByStability(trees)[cons$tip.label]
  plot(cons, tip.color = tipCols)
  PlotTools::SpectrumLegend(
    "bottomright",
    palette = hcl.colors(131, "inferno")[1:101],
    legend = c("Unstable", "", "", "", "Stable"),
    title = "Tip instability\n(per Smith, 2022)",
    bty = "n"
  )
  
  if (nrow(rogues) > 1) {
    legend("topright", rogues[-1, "taxon"], bty = "n", lty = 2)
  }
  
  k <- gsub(".*?xpiwe(\\d[\\d\\.]*)\\.tre", "\\1", treeFile, perl = TRUE)
  if (k == treeFile) {
    k <- Inf
  } else {
    k <- as.numeric(k)
  }
  legend(
    "topleft",
    c(
      "Fitch parsimony", 
      if (is.finite(k)) paste0("Implied weights, k = ", k) else "Equal weights",
      "No 'inapplicable' correction"
  #    paste("Score:", signif(TreeLength(trees[1], dataset, concavity = k)))
    ),
    bty = "n" # No bounding box
  )
  dev.off()
}
