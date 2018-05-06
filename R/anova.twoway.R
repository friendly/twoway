#' ANOVA summary for a two-way table, including Tukey Additivity Test
#'
#' Test for a 1-df interaction in two-way ANOVA table by the Tukey test.
#'
#' @param x a \code{class("twoway")} object
#' @param ... other arguments passed down

anova.twoway <- function(x, ...) {

  r <- length(x$row)
  c <- length(x$col)

  fit <- outer(x$row, x$col, "+") + x$overall
  dat <- fit + x$residuals

  sse <- sum(x$residuals^2)
  dfe <- ( r - 1 ) * ( c - 1 )

  ssrow <- c * sum(x$row^2)
  sscol <- r * sum(x$col^2)

}
