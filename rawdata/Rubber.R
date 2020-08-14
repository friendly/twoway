library(readr)
rubber <- read_csv("rawdata/rubber.csv")
View(rubber)

Rubber <- as.matrix(rubber[,-1])
dimnames(Rubber) <- list(
    "Temperature" = c(0,10,20,25),
    "Pressure" = seq(500,0, -100))

attr(Rubber, "responseName")<- "Volume"

save(Rubber, file="data/Rubber.RData")
