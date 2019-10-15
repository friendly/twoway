## devAskNewPage(ask=FALSE)
## example("medpolish", ask=FALSE)

example("medpolish")
## deaths is now defined
deaths


md <- medpolish(deaths, trace.iter=FALSE) ## base R
md
plot(md)

tmd <- twoway(deaths, method="median")
tmd
plot(tmd)
plot(tmd, which="diagnose")

tmm <- twoway(deaths) ## twoway(deaths, method="means")
tmm
plot(tmm)
plot(tmm, which="diagnose")


## define deathsn with one missing value
deathsn <- deaths
deathsn[1,1] <- NA
deathsn

try(medpolish(deathsn, trace.iter=FALSE)) ## base R ## error
mdn <- medpolish(deathsn, na.rm=TRUE, trace.iter=FALSE) ## base R
mdn
plot(mdn)

try(twoway(deathsn, method="median")) ## error
tmdn <- twoway(deathsn, method="median", na.rm=TRUE)
tmdn
plot(tmdn)
plot(tmdn, which="diagnose")

try(twoway(deathsn)) ## twoway(deathsn, method="means") ## error
tmmn <- twoway(deathsn, na.rm=TRUE) ## twoway(deathsn, method="means", na.rm=TRUE)
tmmn
plot(tmmn)
plot(tmmn, which="diagnose")
