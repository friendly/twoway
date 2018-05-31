## twoway_0.6.2

## I believe as.data.frame.twoway is no longer needed.  I recommend dropping it.

## I am happy with plot.twoway.fit

## plot.twoway_062.R
## twoway-062.R

## 1
taskRT

tw <- twoway(taskRT)
tw

twmed <- twoway(taskRT, method="median")
twmed

plot(tw,    xlim=c(2,7), ylim=c(2,7)) ## they need the same xlim and ylim, so I can alternate them
plot(twmed, xlim=c(2,7), ylim=c(2,7))

plot(tw,    which="diagnose", xlim=c(-.19, .19), ylim=c(-.5, .55))
plot(twmed, which="diagnose", xlim=c(-.19, .19), ylim=c(-.5, .55)) ## only 11 points are visible for the median.
## We need to indicate overplotting.


## 2
Arizona
twA <- twoway(Arizona)
twA

twAmed <- twoway(Arizona, method="median")
twAmed

plot(twA,    xlim=c(20,120), ylim=c(10,100)) ## they need the same xlim and ylim, so I can alternate them
plot(twAmed, xlim=c(20,120), ylim=c(10,100))

plot(twA,    which="diagnose", xlim=c(-7, 8), ylim=c(-1.1, 2))
plot(twAmed, which="diagnose", xlim=c(-7, 8), ylim=c(-1.1, 2)) ## only 15 points are visible for the median.


## 3
insectCounts
twi <- twoway(insectCounts)
twi

twimed <- twoway(insectCounts, method="median")
twimed

plot(twi,    xlim=c(-250, 700), ylim=c(-180, 900)) ## they need the same xlim and ylim, so I can alternate them
plot(twimed, xlim=c(-250, 700), ylim=c(-180, 900))
## needs some more work on locating the varName

plot(twi,    which="diagnose", xlim=c(-160, 170), ylim=c(-200, 400))  ## power = .1
plot(twimed, which="diagnose", xlim=c(-160, 170), ylim=c(-200, 400))  ## power = .3

## Try logarithm

twil <- twoway(log(insectCounts))
twil

twilmed <- twoway(log(insectCounts), method="median")
twilmed

plot(twil,    xlim=c(2, 9), ylim=c(0, 7.5)) ## they need the same xlim and ylim, so I can alternate them
plot(twilmed, xlim=c(2, 9), ylim=c(0, 7.5))
## needs some more work on locating the varName

plot(twil,    which="diagnose", xlim=c(-.35, .3), ylim=c(-2.5, 2.5))
plot(twilmed, which="diagnose", xlim=c(-.35, .3), ylim=c(-2.5, 2.5))

anova(twi)  ## row and col, not varNames
anova(twil)


## 4
data(crash, package="HH")
crash

twc <- twoway(crashrate ~ agerange + passengers, data=crash)
twc           ## HH2, page 528
twc$compValue ## HH2, page 528


plot(twc)
plot(twc, which="diagnose")

try(twcr <- twoway(-10000/crashrate ~ agerange + passengers, data=crash))
## needs a variable in data.frame.  ## Fix.
twcr



crash$crashNegRec <- -10000/crash$crashrate
twcr <- twoway(crashNegRec ~ agerange + passengers, data=crash[,-3])
                                        # this subsetting of crash is a software design error
                                        #   edata <- eval(m$data, parent.frame())  ## wrong
                                        # we actually have to process the formula
twcr  ## variable name crashNegRec not displayed

anova(twc)  ## HH2 Table 14.29, page 529
anova(twcr) ## HH2 Table 14.30, page 531
