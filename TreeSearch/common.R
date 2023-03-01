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

LatestTree <- function(dat, fileStart = "", path = ".") {
  .Failed <- function() {
    if (fileStart == "") {
      NULL
    } else {
      LatestTree(dat, fileStart = "", path)
    }
  }
  
  latestFile <- rev(list.files(
    path = path,
    pattern = paste0("^", fileStart, ".*.nex.trees[^\\.]*$"),
    full.names = TRUE
  ))[1]
  if (is.na(latestFile)) {
    .Failed()
  } else { 
    candidate <- read.nexus(latestFile)[[1]]
    if (length(setdiff(TipLabels(candidate), TipLabels(dat)))) {
      .Failed()
    } else {
      candidate
    }
  }
}
