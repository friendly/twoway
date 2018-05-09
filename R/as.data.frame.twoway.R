#' Convert a twoway object to a data frame

#' This function converts a \code{"twoway"} object to a \code{data.frame}
#'
#' @param x a \code{"twoway"} object
#' @param ... other arguments, presently ignored
#' @export
#' @return a data.frame with \eqn{r \times c} rows corresponding to the input data table, and the following columns
#' \describe{
#'  \item{row}{row labels}
#'  \item{col}{column labels}
#'  \item{data}{the data value in the cell}
#'  \item{fit}{the fitted value}
#'  \item{roweff}{the row effect}
#'  \item{coleff}{the column effec}
#'  \item{nonadd}{the 1 df for non-additivity value}
#' }

#' @examples
#' data(sentRT)
#' sent.2way <- twoway(sentRT)
#' as.data.frame(sent.2way)
#'
# TODO: Should this be a `tidy` method instead?

as.data.frame.twoway <- function(x, ...){

  r <- length(x$roweff)
  c <- length(x$coleff)
  row <- rep(x$rownames, c)
  col <- rep(x$colnames, each=r)
  fit <- c(outer(x$roweff, x$coleff, "+") + x$overall)
  residual <- c(x$residuals)
  data <- fit + residual
  roweff <- rep(x$roweff, c)
  coleff <- rep(x$coleff, each=r)
  nonadd <- c(outer(x$roweff, x$coleff)/x$overall)
#browser()
  result <- data.frame(row, col, data, fit, residual, roweff, coleff, nonadd)
  result
}
