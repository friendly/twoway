data("taskRT")

res <- twoway(taskRT)
names(res)
plot(res)

plot(res, type="diagnose")

# converting wide to long

library(reshape2)
long <- melt(as.matrix(taskRT))
colnames(long) <- c("row", "col", "response")
