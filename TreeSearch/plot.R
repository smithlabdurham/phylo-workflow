TipCol <- function (tip.label) {
  pal <- palette.colors(pal = "Tableau 10")
  blue <- amber <- red <- teal <- green <- gold <- lilac <- pink <- brown <-
    grey <- character(0)
  
  # List taxa against their desired colours here
  blue  <- c("taxon_1", "taxon_2")
  amber <- c("taxon_3", "taxon_4")
  red   <- c("taxon_5", "taxon_6")
  teal  <- c("taxon_7", "taxon_8")
  green <- c("taxon_9", "taxon_10")
  gold  <- c("taxon_11", "taxon_12")
  lilac <- c("taxon_13", "taxon_14")
  pink  <- c("taxon_15", "taxon_16")
  brown <- c("taxon_17", "taxon_18")
  grey  <- c("taxon_19", "taxon_20")
  
  # This sets up the colour vector
  tip.col <- rep("#000000", length(tip.label))
  tip.col[tip.label %in% blue] <- pal[1]
  tip.col[tip.label %in% amber] <- pal[2]
  tip.col[tip.label %in% red] <- pal[3]
  tip.col[tip.label %in% teal] <- pal[4]
  tip.col[tip.label %in% green] <- pal[5]
  tip.col[tip.label %in% gold] <- pal[6]
  tip.col[tip.label %in% lilac] <- pal[7]
  tip.col[tip.label %in% pink] <- pal[8]
  tip.col[tip.label %in% brown] <- pal[9]
  tip.col[tip.label %in% grey] <- pal[10]
  tip.col
}

# REQUIRE tr, a phylo object.
Plot <- function (tr, pdf = FALSE, direction = 'rightwards', font = 3,
                  plotw = 3, ploth = 2.5,
                  pts=10, ec = 'black', bi = FALSE, annot = FALSE, bi.nudge = 0,
                  col.factor = 1, brightest = 0.9, filename = 'plot/plot.pdf',
                  tip.col, fig = FALSE) {
  if (pdf) {
    pdf(file = paste(filename, "pdf", sep = "."), width = plotw,
        height = ploth, pointsize = pts, colormodel = 'rgb')
    on.exit(dev.off())
  }
  tip.label <- tr$tip.label
  nTip <- length(tip.label)
  nNode <- tr$Nnode
  
  if (fig == FALSE) {
    tip.col <- TipCol(tip.label)
  } else {
    tip.col <- 'black';
  }
  
  if (bi) label.offset <- 2 * min(tr$edge.length)
  oPar <- par(cex = 0.8)  # Character expansion
  on.exit(par(oPar), add = TRUE)
  if (direction == 'rightwards') {
    align <- 0
  } else {
    align <- 0.5
  }
  plot(tr,
       edge.color = ec,
       edge.width = 2,
       font = font,
       cex = 1,
       tip.col = tip.col,
       adj = align,
       label.offset = 0.5,
       use.edge.length = bi,
       direction = direction,
       no.margin = TRUE,
       root.edge = TRUE,
       underscore = TRUE
  )
  
  if (annot) {
    labex <- regexpr("([0-9]+)", tr$node.label);
    lablen <- attr(labex, 'match.length')
    lab <- ifelse(lablen > 0 & lablen < 3,
                  substr(tr$node.label, labex, labex + lablen - 1),
                  " ")
    nodelabels(lab, adj = c(nudgel + bi.nudge, -0.5), frame = 'none', cex = 0.8)
  }
  
  
}

ColPlot <- function (tr, taxnames = '', direction = 'rightwards',
                     ec = 0, ...) {
  tr1 <- tr
  tip.label <- tr$tip.label
  nTip <- length(tip.label)
  nNode <- tr$Nnode
  # Taxon names and nodes
  roman <- c('Tardigrada', 'Onychophora', 'Priapulida', 'Collins monster', 'Collins',
             'Collins_monster', 'Collins_monster_Emu_Bay', 'Siberian Orsten tardigrade', 'Siberian_Orsten_tardigrade'
             , 'Modern_priapulid')
  bold <- c("Opabinia")
  tip.col <- TipCol(tip.label)
  
  for (tax in names(taxnames)) {
    taxa <- taxnames[[tax]]
    tr <- drop.tip(tr, which(tr$tip.label%in%taxnames[[tax]]), subtree = TRUE)
    new.clade.name <- paste(tax, " (", length(taxnames[[tax]]), ")", sep = "")
    tr$tip.label[length(tr$tip.label)] <- new.clade.name
    roman <- c(roman, new.clade.name)
  }
  
  nTip <- length(tr$tip.label)
  nNode <- tr$Nnode
  font <- (!(tr$tip.label %in% roman))*2+1+(tr$tip.label %in% bold)
  Plot(tr, direction = direction, font = font, ec = ec, tip.col = tip.col, ...)
}

RoguePlot <- function(trees, outgroup) {
  # Ignore outgroup taxa that aren't in tree
  outgroup <- intersect(outgroup, TipLabels(c(trees)[[1]]))
  if (length(outgroup)) {
    # Root trees on outgroup
    trees <- RootTree(trees, outgroup)
  }
  rogues <- Rogue::QuickRogue(trees, p = 1)
  cons <- ConsensusWithout(trees, rogues[-1, "taxon"])
  
  ColPlot(cons, ec = "black")
  if (nrow(rogues) > 1) {
    legend("topleft", rogues[-1, "taxon"], bty = "n", lty = 2)
  }
}
