source("common.R")

searchRepeats <- 3 # Number of times to continue search at each k
kValues <- c(10, 40, 3, 20, 6) # Concavity constants for implied weighting
timeout <- 60 # Minutes after which to terminate each search

# Load data from locally downloaded matrix
latest <- LatestMatrix()
dat <- ReadAsPhyDat(latest)
message("* Read ", latest)

resultsFile <- ResultsFile(latest, "ew")
if (file.exists(resultsFile)) {
  startTree <- read.nexus(c(resultsFile))[[1]]
} else {
  startTree <- AdditionTree(dat)
}

best <- MaximizeParsimony(dataset = dat, tree = startTree, maxTime = timeout)
write.nexus(best, file = resultsFile)


for (repetition in seq_len(searchRepeats)) for (k in kValues) {
  resultsFile <- ResultsFile(latest, "iw", k)
  if (file.exists(resultsFile)) {
    startTree <- read.nexus(c(resultsFile))[[1]]
  } else {
    startTree <- AdditionTree(dat, concavity = k)
  }
  best <- MaximizeParsimony(dataset = dat, tree = startTree, concavity = k, maxTime = timeout)
  write.nexus(best, file = resultsFile)
}
