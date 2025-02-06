## Set variables here
 
# Taxa on which to root tree
outgroup <- c("Kinorhynchus", "Pliciloricus")

# Directory containing TreeSearch results
# A leading ../ denotes a path relative to this `Summaries` directory
treeSearchDir <- "../TreeSearch"

# Maximum trees to retain from a parsimony search
maxParsTrees <- Inf

# Directory containing Bayesian results
# All results in this directory will be summarized -
# ensure that only current results of the desired run are present!
bayesDir <- "../MrBayes"

# Set burn in fraction to use when summarizing Bayesian trees
# If `NULL`, this will be read from the MrBayes file
burninFrac <- NULL

# Maximum number of trees to retain when summarizing Bayesian results
treesPerRun <- 72

# Name of output file to create, in this `Summaries` directory by default
pdfFile <- "Tree-summary.pdf"

################################################################################
# You shouldn't need to edit anything below this line
################################################################################

pdf(sub("\\.pdf\\.pdf$", ".pdf", paste0(pdfFile, ".pdf")),
    width = 8, height = 10)

Path <- function(...) {
  paste0(c(...), collapse = "/")
}

source(Path(treeSearchDir, "common.R"))
source(Path(treeSearchDir, "plot.R"))


################################################################################
# TreeSearch results
################################################################################
latest <- LatestMatrix(treeSearchDir)
dat <- ReadAsPhyDat(latest)
treeFiles <- list.files(
  path = treeSearchDir,
  pattern = paste0(".+_", sub("^.*/", "", latest), ".trees"),
  full.names = TRUE
)
ks <- KValue(treeFiles)

for (treeFile in treeFiles[order(ks)]) {
  trees <- read.nexus(treeFile)
  if (length(trees) > maxParsTrees) {
    trees <- trees[seq.int(1, length(trees), length.out = maxParsTrees)]
  }
  if (!all(outgroup %in% TipLabels(trees[[1]]))) {
    warning("Outgroup taxa ",
            paste(setdiff(outgroup, TipLabels(trees[[1]])), collapse = ", "),
            " not found in tree.", immediate. = TRUE)
    outgroup <- TipLabels(trees[[1]])[[1]]
    message("Setting outgroup to ", outgroup)
  }
  RoguePlot(trees, outgroup)
  
  k <- KValue(treeFile)
  legend(
    "topright",
    c(
      sub(
        "ew", "Equal weights", fixed = TRUE,
        sub(
          "iw", "Implied weights, k = ", fixed = TRUE,
          sub("^(?:.*/)*([^/_]+)_.+", "\\1", treeFile, perl = TRUE)
        )
      ),
      paste(length(trees), "trees"),
      paste("Score:", signif(TreeLength(trees[1], dat, concavity = k)))
    ),
    bty = "n" # No bounding box
  )
}

################################################################################
# Bayesian results
################################################################################
treeFiles <- list.files(bayesDir, "*\\.run\\d+\\.t$", full.names = TRUE)
matrixFile <- gsub("\\.run\\d+\\.t", "", treeFiles[1])
matrixLines <- readLines(matrixFile)
if (is.null(burninFrac)) {
  burninLines <- grep("burninf(?:r(?:a(?:c)?)?)?\\s*=", matrixLines)
  burninFrac <- as.double(
    gsub(".*burninf(?:r(?:a(?:c)?)?)?\\s*=\\s*([0-9\\.]*).*?$", "\\1",
         matrixLines[burninLines])
  )
}

if (length(unique(burninFrac)) > 1) {
  warning("Inconisistent burnin fractions: ",
          paste(burninFrac, collapse = "; "), "; using largest.")
}
burninFrac <- max(burninFrac)

trees <- do.call(c, lapply(treeFiles, function(treeFile) {
  trees <- read.nexus(treeFile, force.multi = TRUE)
  nTrees <- length(trees)
  from <- ceiling(nTrees * burninFrac)
  trees[seq.int(from = from, to = nTrees,
                length.out = min(treesPerRun, nTrees - from + 1))]
}))

cons <- RoguePlot(trees, outgroup, p = 0.5)[["cons"]]
splitFreqs <- SplitFrequency(cons, trees) / length(trees)
LabelSplits(cons, round(splitFreqs * 100),
            col = SupportColour(splitFreqs),
            frame = "none", pos = 3, cex = 0.8)
legend(
  "topright",
  c(
    "Bayesian analysis",
    "Majority rule consensus"
  ),
  bty = "n" # No bounding box
)

PlotTools::SpectrumLegend(
  "bottomright", bty = "n",
  legend = seq.int(100, 50, -10),
  title = "PP / %",
  title.font = 2,
  palette = rev(colorspace::diverge_hcl(
    101, h = c(260, 0), c = 100, l = c(50, 90), power = 1
    ))[51:100],
  xpd = NA
)

dev.off()
