#' Fit a two-way table using median polish
#'
#' @param x a numeric matrix or data frame
#' @param trace.iter whether to give verbose output of iteration history in median polish.
#' @param ... other arguments passed down
#' @importFrom stats medpolish
#' @export
#' @return An object of class \code{c("twoway", "medpolish")} with the following named components:
#' \describe{
#'  \item{overall}{the fitted constant term.}
#'  \item{roweff}{the fitted row effects.}
#'  \item{coleff}{the fitted column effects.}
#'  \item{residuals}{the residuals.}
#'  \item{name}{the name of the dataset.}
#'  \item{rownames}{the names for the rows}
#'  \item{colnames}{the names for the columns}
#'  \item{method}{"median"}
#' }


medianfit <- function(x, trace.iter=FALSE, ...) {
  result <- stats::medpolish(x, trace.iter=trace.iter, ...)
  names(result)[2:3] <- c("roweff", "coleff")
  result$name <-  deparse(substitute(x))
  result$rownames <- rownames(x)
  result$colnames <- colnames(x)
  # result$roweff <- result$row - result$overall
  # result$coleff <- result$col - result$overall
  result$method <- "median"
  class(result) <- c("twoway", "medpolish")
  result
}

#' Fit a two-way table using row and column means
#'
#' @param x a numeric matrix or data frame
#'
#' @param ... other arguments passed down
#' @param na.rm logical. Should missing values be removed?
#' @export
#' @return An object of class \code{c("twoway")} with the following named components:
#' \describe{
#'  \item{overall}{the fitted constant term.}
#'  \item{roweff}{the fitted row effects.}
#'  \item{coleff}{the fitted column effects.}
#'  \item{residuals}{the residuals.}
#'  \item{name}{the name of the dataset.}
#'  \item{rownames}{the names for the rows}
#'  \item{colnames}{the names for the columns}
#'  \item{method}{"median"}
#' }


meanfit <-
function (x, ..., na.rm=FALSE)
{
    z <- as.matrix(x)
    nr <- nrow(z)
    nc <- ncol(z)
    r <- numeric(nr)
    c <- numeric(nc)
    overall <- mean(z, na.rm=na.rm)
    roweff <- rowMeans(z, na.rm=na.rm) - overall
    coleff <- colMeans(z, na.rm=na.rm) - overall
    residuals <- z - outer(roweff, coleff, "+") - overall
    names(roweff) <- rownames(z)
    names(coleff) <- colnames(z)
    ans <- list(overall = overall, roweff = roweff, coleff = coleff,
        residuals = residuals, name = deparse(substitute(x)),
        rownames = rownames(z), colnames = colnames(z), method = "mean")
    class(ans) <- "twoway"
    ans
}

