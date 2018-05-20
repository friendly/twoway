data("taskRT")

res <- twoway(taskRT)
names(res)
plot(res)
plot(res, type="diagnose")



# converting wide to long for this example

library(reshape2)
long <- melt(as.matrix(taskRT))
colnames(long) <- c("task", "topic", "RT")

# convert wide to long
Wide <- dcast(long, task ~ topic, value.var="RT")

library(tidyr)
wide <- spread(long, key=topic, value=RT)

# base, unstack

wide <- unstack(long, form = RT ~ topic)
rownames(wide) <- unique(long$task)
wide

# test formula method

twoway(RT ~ task + topic, data=long)
