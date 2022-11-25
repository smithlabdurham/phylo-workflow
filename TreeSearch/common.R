# Load libraries
library("TreeTools")
library("TreeSearch")

# Define functions
ResultsFile <- function(latest, weighting, k = NULL) {
  paste0(
    sub("/(.*?)$", paste0("/", weighting, if (!is.null(k)) signif(k), "_\\1"), latest),
    ".trees"
  )
}

LatestMatrix <- function(path = ".") {
  rev(list.files(
    path = path, 
    pattern = "*.nex[^\\.]*$",
    full.names = TRUE
  ))[1]
}
