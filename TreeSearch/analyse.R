source("common.R")

searchRepeats <- 3 # Number of times to continue search at each k
kValues <- c(10, 40, 3, 20, 6) # Concavity constants for implied weighting
timeout <- 60 # Minutes after which to terminate each search
ratchets <- 8 # Ratchet iterations

# Load data from locally downloaded matrix
latest <- LatestMatrix()
message("* Reading ", latest)
dat <- ReadAsPhyDat(latest)

resultsFile <- ResultsFile(latest, "ew")

startTree <- LatestTree(dat, "ew")
if (is.null(startTree)) {
  startTree <- AdditionTree(dat)
}

best <- MaximizeParsimony(
  dataset = dat,
  tree = startTree,
  maxHits = hits,
  ratchIter = ratchets,
  maxTime = timeout
)
write.nexus(best, file = resultsFile)


for (repetition in seq_len(searchRepeats)) for (k in kValues) {
  resultsFile <- ResultsFile(latest, "iw", k)
  startTree <- LatestTree(dat, paste0("iw", k))
  if (is.null(startTree)) {
    startTree <- AdditionTree(dat, concavity = k)
  }
  best <- MaximizeParsimony(
    dataset = dat,
    tree = startTree,
    concavity = k,
    maxHits = hits,
    ratchIter = ratchets,
    maxTime = timeout
  )
  write.nexus(best, file = resultsFile)
}
