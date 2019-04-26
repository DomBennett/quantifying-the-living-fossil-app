csv_file <- 'data/appendix_6.csv'
x <- read.csv(file = csv_file, skip = 3, stringsAsFactors = FALSE)
# clean and simplify for shiny
pull <- x$Common.name..if.available. != ''
nms <- x$Scientific.name
nms[pull] <- paste0(nms[pull], ' (', x$Common.name..if.available.[pull], ')')
x$Scientific.name <- nms
x$X...pEPI. <- paste0('(', x$X...pEPI., ')')
x <- x[ , c(-1, -3)]
x$Change[x$Change == '-'] <- NA
x$ED[x$ED == '-'] <- NA
x$EPI[x$EPI == '-'] <- NA
# ED and EPI seem to be the wrong way round
colnames(x) <- c("Taxon", 'Group', 'N. spp.', 'Age (MY)', '\'Success\'',
                 '\'Change\'', 'pEPI', '.', 'EPI', 'ED (MY)')
# init with most-living-fossil mammals and birds
x1 <- x[x$Group %in% c('Mammals', 'Aves'), ]
x2 <- x[!x$Group %in% c('Mammals', 'Aves'), ]
x <- rbind(x1, x2)
rownames(x) <- NULL
saveRDS(object = x, file = 'data/appendix_6.RData', compress = 'xz')
