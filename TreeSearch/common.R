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

LatestMatrix <- function(path = ".", full.names = TRUE) {
  rev(list.files(
    path = path, 
    pattern = "*.nex[^\\.]*$",
    full.names = full.names
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
    candidate <- read.nexus(latestFile, force.multi = TRUE)[[1]]
    if (length(setdiff(TipLabels(candidate), TipLabels(dat)))) {
      .Failed()
    } else {
      candidate
    }
  }
}

KValue <- function(treeFile) {
  k <- gsub(".*?iw(\\d[\\d\\.]*)_.*", "\\1", treeFile, perl = TRUE)
  
  # Return:
  ifelse(k == treeFile, Inf, suppressWarnings(as.numeric(k)))
}
