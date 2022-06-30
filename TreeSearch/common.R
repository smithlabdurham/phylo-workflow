# Load libraries
library("TreeTools")
library("TreeSearch")

# Define functions
ResultsFile <- function(latest, weighting, k = NULL) {
  paste0(weighting, if (!is.null(k)) signif(k), "_", latest, ".trees")
}

LatestMatrix <- function() {
  rev(list.files(pattern = "*.nex"))[1]
}
