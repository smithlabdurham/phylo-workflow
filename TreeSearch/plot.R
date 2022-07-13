TipCol <- function (tip.label) {
  dreary <- red <- dull <- lime <- indigo <- ruby <- black <- jade <- straw <- fuschia <- character(0)
  dreary <- c('Priapulida', 'Ottoia_prolifica', 'Modern_priapulid',
              'Tubiluchus_Priapulida', 'Tubiluchus_priapulida', 'Cricocosmia')
  
  gold <- c('Leanchoilia', 'Alalcomenaeus', 'Kuamaia_lata',
            'Misszhouia_longicaudata', 'Supella_longipalpa',
            'Chengjiangocaris', 'Eoredlichia', 'Fuxianhuia', 'Isoxys',
            'Euarthropoda')
  straw <- c(
    c('Hadranax', 'Kerygmachela', 'Pambdelurion'),
    c('Siberion', 'Megadictyon', 'Jianshanopodia')
  )
  bronze <- c(
    c('Anomalocaris', 'Opabinia', 'Peytoia', 'Parapeytoia', 'Laggania',
      'Caryosyntrips_camurus', 'Caryosyntrips', 'C.f._Peytoia_USNM_57490',
      'Hurdia', 'Wheeler_Opabiniid', "Utaurora"),
    c('Schinderhannes', 'Lyrarapax_unguispinus', 'Pambdelurion_whittingtoni',
      'Opabinia_regalis', 'Anomalocaris_canadensis', 'Peytoia_nathorsti',
      'Peytoia_infercambriensis', "Stanleycaris",
      'Hurdia_victoria', 'Cucumericrus', 'Kylinxia',
      'Amplectobelua_symbrachiata', 'Cambroraster_falcatus', 'Parvibellus_atavus',
      'Aegirocassis_benmoulai', 'Lyrarapax_unguispinus', 'Schinderhannes_bartlesi')
  )
  racing <- c('Actinarctus_(heterotardigrada)', 'Macrobiotus_(eutardigrada)',
              'Halobiotus_(eutardigrada)',
              'Halobiotus', 'Actinarctus',
              'Actinarctus_(Heterotardigrada)', 'Macrobiotus_(Eutardigrada)',
              'Actinarctus_Heterotardigrada',     'Halobiotus_crispae_Eutardigrada',
              'Halobiotus_Eutardigrada', 'Macrobiotus_Eutardigrada',
              'Actinarctus_', 'Tardigrada', 'Macrobiotus_',
              'Siberian Orsten tardigrade', 'Siberian_Orsten_tardigrade',
              'Siberian_orsten_tardigrade')
  jade <-  'Onychodictyon_ferox'
  galazios <- NULL
  hallucishaniids <- c('Hallucigenia_sparsa', 'Hallucigenia_fortis',
                       'Hallucigenia_hongmeia', 'Carbotubulus', 'Luolishania',
                       'Thanahita_distos', 'Facivermis_yunnanicus',
                       'Ovatiovermis_cribratus', 'Collinsovermis_monstruosus',
                       'Miraluolishania', 'Collins_monster_Emu_Bay', 'Collins_monster_emu_bay',
                       'Acinocricus', 'Collinsium')
  onyCrown <- c('Euperipatoides_Onychophora', 'Euperipatoides_(Onychophora)',
                'Euperipatoides', 'Ooperipatellus', 'Plicatoperipatus',
                'Ooperipatellus_Onychophora', 'Plicatoperipatus_Onychophora',
                'Tertiapatus_dominicanus')
  onies <- c(onyCrown, 'Antennacanthopodia', 'Cardiodictyon', 'Microdictyon',
             'Paucipodia', 'Onychodictyon_gracilis',
             'Helenodora', 'Ilyodes', 'Tritonychus_phanerosarkus', 'Tritonychus',
             'Orstenotubulus')
  aquamarine <- c('Aysheaia', 'Siberion', 'Paucipodia',
                  'Xenusion', 'Diania')
  
  tip.col <- rep('black', length(tip.label))
  tip.col[tip.label %in% straw] <- '#ac9c16'
  tip.col[tip.label %in% gold] <- '#d2951d'
  tip.col[tip.label %in% bronze] <- '#a2751c'
  tip.col[tip.label %in% lime] <- '#99be16'
  tip.col[tip.label %in% racing] <- '#25ac89'
  tip.col[tip.label %in% ruby] <- '#c02349'
  tip.col[tip.label %in% fuschia] <- '#c82298'
  tip.col[tip.label %in% red] <- '#e1001b'
  tip.col[tip.label %in% hallucishaniids] <- '#a62bc5'
  tip.col[tip.label %in% black] <- '#000000'
  tip.col[tip.label %in% dreary] <- '#566666'
  tip.col[tip.label %in% dull] <- '#8e8e8e'
  tip.col[tip.label %in% jade] <- '#25ac89'
  tip.col[tip.label %in% galazios] <- '#009bdd'
  tip.col[tip.label %in% aquamarine] <- '#004d98'
  tip.col[tip.label %in% onies] <- '#aa6cb9'
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
