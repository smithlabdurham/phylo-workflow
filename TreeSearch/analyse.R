source("common.R")

# Load data from locally downloaded copy of MorphoBank matrix

latest <- LatestMatrix()
dat <- ReadAsPhyDat(latest)
message("* Read ", latest)

resultsFile <- ResultsFile(latest, "ew")
if (file.exists(resultsFile)) {
  startTree <- read.nexus(c(resultsFile))[[1]]
} else {
  startTree <- AdditionTree(dat)
}

best <- MaximizeParsimony(dat, startTree)
write.nexus(best, file = resultsFile)

kValues <- c(10, 40, 3, 20, 6)

for (k in kValues) {
  resultsFile <- ResultsFile(latest, "iw", k)
  if (file.exists(resultsFile)) {
    startTree <- c(resultsFile)[[1]]
  } else {
    startTree <- AdditionTree(dat, concavity = k)
  }
  best <- MaximizeParsimony(dat, concavity = k)
  write.nexus(best, file = resultsFile)
}

