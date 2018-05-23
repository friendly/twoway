data("taskRT")

res <- twoway(taskRT)
names(res)
plot(res)
plot(res, type="diagnose")



# converting wide to long for this example

library(reshape2)
long <- melt(as.matrix(taskRT))
colnames(long) <- c("task", "topic", "RT")

library(tidyr)
longRT <-taskRT %>%
      tibble::rownames_to_column("task") %>%
      tidyr::gather(key="topic", value=RT, -task)


# convert wide to long: dcast
(wide <- dcast(long, task ~ topic, value.var="RT"))
twoway(wide[,-1])

# tidyr::spread
library(tidyr)
(wide <- spread(long, key=topic, value=RT))
twoway(wide[,-1])


# base, unstack
wide <- unstack(long, form = RT ~ topic)
rownames(wide) <- unique(long$task)
twoway(wide)

# test formula method

twoway(RT ~ task + topic, data=long)
