load(file.path(myutil::dropbox_folder(), "R", "data", "histdata", "EdgeworthDeaths.RData"))
#load("C:/Users/friendly/Dropbox/R/data/histdata/EdgeworthDeaths.RData")

library(tidyr)
Edgeworth.tab <- spread(EdgeworthDeaths, year, Freq) %>%
  dplyr::select(-County) %>%
  as.matrix()
rownames(Edgeworth.tab) <- levels(EdgeworthDeaths$County)

EDfit <- meanfit(Edgeworth.tab)
names(EDfit)

ED2way <- twoway(Edgeworth.tab)
names(ED2way)
ED2way

twoway(Edgeworth.tab, method="median")
