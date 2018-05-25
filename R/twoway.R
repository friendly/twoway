# Functions for Tukey analysis of two-way tables

#' Analysis of a two-way table with one observation per cell
#'
#' Fits an additive model using either row and column means or Tukey's median polish procedure
#'
#' @details The \code{rownames(x)} are used as the levels of the row factor and the \code{colnames(x}) are
#'          the levels of the column factor.
#'          For a numeric matrix, the function uses the \code{names(dimnames(x))} as the names of these
#'          variables, and, if present, a \code{responseName} attribute as the name for the response variable.
#' @param x a numeric matrix or data frame.
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
#' @return An object of class \code{"twoway"}, but supplemented by additional components used for labeling
#' @seealso \code{\link{medianfit}}, \code{\link{meanfit}}
#' @examples
#' data(taskRT)
#' twoway(taskRT)
#'

# TODO: The function now needs default arguments for `responseName` and `varNames`
twoway.default <- function(x, method=c("mean", "median"), ...) {

  method <- match.arg(method)
  if (method=="mean")
    result <- meanfit(x)
  else
    result <- medianfit(x, ...)
  result$name <- deparse(substitute(x))

  # keep the varNames and responseName in the object
  # TODO: how to handle this for a data.frame input?
  if (is.matrix(x)) {
    if(!is.null(attr(x, "response"))) responseName <- attr(x, "response") else responseName <- "value"
    if(!is.null(names(dimnames(x)))) varNames <- names(dimnames(x)) else varNames <- c("Row", "Col")
  }
  else {
    responseName <- "value"
    varNames <- c("Row", "Col")
  }
  result$varNames <- varNames
  result$responseName <- responseName

  # add the slope to the object here [RMH]
  comp <- c(outer(result$roweff, result$coleff)/result$overall)
  res <- c(result$residuals)
  fit <- lm(res ~ comp)
  result$slope <- coef(fit)[2]
  result

}


