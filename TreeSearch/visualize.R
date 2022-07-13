source("common.R")
source("plot.R")
library("Rogue")

outgroup <- c("Tubiluchus_priapulida") # Specify outgroup taxa to root tree

latest <- LatestMatrix()
dat <- ReadAsPhyDat(latest)
treeFiles <- list.files(pattern = paste0(".+_", latest, ".trees"))

for (treeFile in treeFiles) {
  trees <- read.nexus(treeFile)
  
  # Ignore outgroup taxa that aren't in tree
  outgroup <- intersect(outgroup, TipLabels(trees)[[1]])
  if (length(outgroup)) {
    # Root trees on outgroup
    trees <- RootTree(trees, outgroup)
  }
  rogues <- QuickRogue(trees, p = 1)
  cons <- ConsensusWithout(trees, rogues[-1, "taxon"])
  
  pdf(gsub(".trees", ".pdf", treeFile, fixed = TRUE), 
      width = 8, height = 10)
  ColPlot(cons, ec = "black")
  if (nrow(rogues) > 1) {
    legend("topleft", rogues[-1, "taxon"], bty = "n", lty = 2)
  }
  k <- gsub(".*?(\\d[\\d\\.]*)_.*", "\\1", treeFile, perl = TRUE)
  if (k == "") {
    k <- Inf
  } else {
    k <- as.numeric(k)
  }
  legend("topright", c(
    gsub("_.+", "", treeFile),
    paste("Score:", signif(TreeLength(trees[1], dat, concavity = k)))
    ), bty = "n"
  )
  
  
  distances <- TreeDist::ClusteringInfoDistance(trees)
  whenHit <- gsub("_\\d+$", "", names(trees), perl = TRUE)
  firstHit <- table(whenHit)
  searchStages <- length(firstHit)
  map <- cmdscale(distances, k = 3)
  cols <- hcl.colors(searchStages, alpha = 0.8)
  presOrder <- c("seed", "start", paste0("ratch", 1:10000), "final")
  presOrder <- c(presOrder, setdiff(names(firstHit), presOrder))
  treeCols <- cols[match(whenHit, intersect(presOrder, whenHit))]
  par(mar = rep(0, 4))
  TreeDist::Plot3(map,
                  col = treeCols,
                  pch = 16, cex = 2,
                  axes = FALSE, xlab = "", ylab = "", asp = 1)
  TreeTools::MSTEdges(distances, plot = TRUE, map[, 1], map[, 2],
                      col = '#00000030', lty = 2)
  legend("topright", 
         intersect(presOrder, names(firstHit)),
         col = cols, pch = 16, bty = "n")
  
  dev.off()
}

