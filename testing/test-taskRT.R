data("taskRT")

res <- twoway(taskRT)
plot(res)

plot(res, type="diagnose")
