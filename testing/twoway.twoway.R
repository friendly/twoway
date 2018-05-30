twoway.twoway <- function(x, ...) {
  if (x$method=="Initial")
    twoway.default(x$residuals, ..., name=x$name)
  else  ## this needs more thinking.
    x
}
