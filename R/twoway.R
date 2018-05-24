# Functions for Tukey anslysis of two-way tables

#' Analysis of a two-way table with one observation per cell
#'
#' Fits an additive model using either row and column means or Tukey's median polish procedure
#'
#' @details The \code{rownames(x)} are used as the levels of the row factor and the \code{colnames(x}) are
#'          the levels of the column factor.
#' @param x a numeric matrix or data frame
#' @param ... other arguments passed down
#' @rdname twoway
#' @author Michael Friendly
#' @seealso code{\link[stats]{medpolish}}
#' @references Tukey, J. W. (1977). \emph{Exploratory Data Analysis}, Reading MA: Addison-Wesley.
#'             Friendly, M. (1991). \emph{SAS System for Statistical Graphics} Cary, NC: SAS Institute
#' @export

twoway <-
	function(x, ...) UseMethod("twoway")

#' Default method for two-way tables

#' @param method one of \code{"mean"} or \code{"median"}
#'
#' @rdname twoway
#' @method twoway default
#' @export
#' @return An object of class \code{"twoway"}
#' @seealso \code{\link{medianfit}}, \code{\link{meanfit}}
#' @examples
#' data(taskRT)
#' twoway(taskRT)
#'

twoway.default <- function(x, method=c("mean", "median"), ...) {

  method <- match.arg(method)
  if (method=="mean")
    result <- meanfit(x)
  else
    result <- medianfit(x, ...)
  result$name <- deparse(substitute(x))
  result

}


# ## diagnostic plot for removable interaction, from stats::medpolish
# plot.medpolish <-
# function (x, main = "Tukey Additivity Plot", ...)
# {
# 		comp <- outer(x$row, x$col)/x$overall
# 		res <- x$residuals
#     plot(comp, x$residuals, main = main,
#         xlab = "Diagnostic Comparison Values", ylab = "Residuals",
#         ...)
#     abline(lm(res ~ comp))
#     abline(h = 0, v = 0, lty = "dotted")
# }


