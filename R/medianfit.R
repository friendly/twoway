#' Fit a two-way table using median polish
#'
#' @param x a numeric matrix
#' @param trace.iter whether to give verbose output of iteration history in median polish.
#' @param ... other arguments passed down
#' @importFrom stats medpolish
#' @export
#' @return An object of class \code{c("twoway", "medpolish")} with the following named components:
#' \describe{
#'  \item{overall}{the fitted constant term.}
#'  \item{row}{the fitted row effects.}
#'  \item{col}{the fitted column effects.}
#'  \item{residuals}{the residuals.}
#'  \item{name}{the name of the dataset.}
#' }


medianfit <- function(x, trace.iter=FALSE, ...) {
  result <- stats::medpolish(x, trace.iter=trace.iter, ...)
  result$rownames <- rownames(x)
  result$colnames <- colnames(x)
  result$name <-  deparse(substitute(x))
  #	result$roweff <- result$row - result$overall
  #	result$coleff <- result$col - result$overall
  result$method <- "median"
  class(result) <- c("twoway", "medpolish")
  result
}

#' Fit a two-way table using row and column means
#'
#' @param x a numeric matrix
#' @param ... other arguments passed down
#' @export
#' @return An object of class \code{c("twoway")} with the following named components:
#' \describe{
#'  \item{overall}{the fitted constant term.}
#'  \item{row}{the fitted row effects.}
#'  \item{col}{the fitted column effects.}
#'  \item{residuals}{the residuals.}
#'  \item{name}{the name of the dataset.}
#' }


meanfit <- function(x, ...) {
  z <- as.matrix(x)
  nr <- nrow(z)
  nc <- ncol(z)
  r <- numeric(nr)
  c <- numeric(nc)
  overall <- mean(z)
  row <- rowMeans(z) - overall
  col <- colMeans(z) - overall
  residuals <- z - outer(row, col) - overall
  names(row) <- rownames(z)
  names(col) <- colnames(z)
  ans <- list(overall = overall, row = row, col = col, residuals = residuals,
              name = deparse(substitute(x)),
              method = "mean")
  class(ans) <- "twoway"
  ans
}

