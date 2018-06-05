## using 0.6.2
library(twoway)


Arizona
twA <- twoway(Arizona)
twA

twAmed <- twoway(Arizona, method="median")
twAmed

plot(twA,    xlim=c(20,120), ylim=c(10,100)) ## they need the same xlim and ylim, so I can alternate them
plot(twAmed, xlim=c(20,120), ylim=c(10,100))

plot(twA,    which="diagnose", xlim=c(-7, 8), ylim=c(-1.1, 2))
plot(twAmed, which="diagnose", xlim=c(-7, 8), ylim=c(-1.1, 2)) ## only 15 points are visible for the median.


## load from testing/plot.twoay.boxplot.R
plot.twoway.boxplot(twA) ## xlab wrong
plot.twoway.boxplot(twA, by="col") ## broken ## at a minimum you need by <- match.arg(by), but that isn't enough
plot.twoway.boxplot(twoway(t(Arizona))) ## xlab wrong
## I recommend removing this file before releasing even a preliminary version of the package.


## This is how I would do it
library(HH)
AZlong <- to_long(Arizona)
position(AZlong$City) <- c(1.5, 4, 6.5)

interaction2wt(Temperature ~ Month + City, data=AZlong)

interaction2wt(to_long(twA$residuals)$Temperature ~ Month + City, data=AZlong,
               responselab="Residual",
               main="Residuals from 'mean' model")

interaction2wt(zapsmall(to_long(twAmed$residuals)$Temperature) ~ Month + City, data=AZlong,
               responselab="Residual",
               main="Residuals from 'median' model")


## force common ylim scale
interaction2wt(to_long(twA$residuals)$Temperature ~ Month + City, data=AZlong,
               responselab="Residual",
               main="Residuals from 'mean' model",
               ylim=c(-1.5, 2.1))

interaction2wt(zapsmall(to_long(twAmed$residuals)$Temperature) ~ Month + City, data=AZlong,
               responselab="Residual",
               main="Residuals from 'median' model",
               ylim=c(-1.5, 2.1))




## sentRT

tws <- twoway(sentRT)
plot(tws)
plot(tws, which="diagnose")

sentlong <- to_long(sentRT)

interaction2wt(sentRT ~ Row + Col, data=sentlong)

interaction2wt(to_long(tws$residuals)$tws.residuals ~ Row + Col, data=sentlong,
               responselab="Residual",
               main="Residuals from 'mean' model")


interaction2wt(I(-1/sentRT) ~ Row + Col, data=sentlong)

interaction2wt(I(-sentRT^-.75) ~ Row + Col, data=sentlong)

interaction2wt(I(-1/sqrt(sentRT)) ~ Row + Col, data=sentlong)

