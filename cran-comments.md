## Test environments
* local Win 64 install, 3.6.3 (2020-02-29)
* win-builder R Under development (unstable) (2020-06-23 r78741)
* travis CI via github

## R CMD check results

0 errors | 0 warnings | 0 notes

### Version 0.6.3

This is a development release:

* revised `plot.twoway()` to use and default to na.rm=FALSE
* revised `plot.twoway.fit()` to use and default to na.rm=FALSE
* revised `meanfit()` to use and default to na.rm=FALSE
* revised `twoway.default()` to pass ... (hence na.rm) to meanfit
* added demo/ directory
* added demo/example-na.r to illustrate use of na.rm
* added demo/00Index
* Turn on travis CI

## Reverse dependencies

> devtools::revdep()
character(0)


