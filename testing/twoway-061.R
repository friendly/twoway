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
#' @return An object of class \code{c("twoway")} with the following named components:
#' \describe{
#'  \item{overall}{the fitted constant term.}
#'  \item{roweff}{the fitted row effects.}
#'  \item{coleff}{the fitted column effects.}
#'  \item{residuals}{the residuals.}
#'  \item{name}{the name of the dataset.}
#'  \item{rownames}{the names for the rows}
#'  \item{colnames}{the names for the columns}
#'  \item{method}{the fitting method}
#'  \item{varNames}{the names of the row and column variables}
#'  \item{responseName}{the name of the response variable}
#'  \item{slope}{the slope value, for the diagnostic plot}
#' }
#' @rdname twoway
#' @author Michael Friendly
#' @seealso code{\link{twoway.formula}}, code{\link[stats]{medpolish}}
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
#' @importFrom stats lm coef
#' @examples
#' data(taskRT)
#' twoway(taskRT)
#'

twoway.default <- function(x, method=c("mean", "median"), ...,
                           name=deparse(substitute(x)),
                           responseName=attr(x, "response"),
                           varNames=names(dimnames(x))) {

  if (is.null(responseName)) responseName <- "Value"
  if (is.null(varNames)) varNames <- c("Row", "Col")

  method <- match.arg(method)
  if (method=="mean")
    result <- meanfit(x)
  else
    result <- medianfit(x, ...)
  result$name <- name
  result$varNames <- varNames
  result$responseName <- responseName
  result$compValue <- with(result, matrix(roweff) %*% coleff/overall) ## rmh
  dimnames(result$compValue) <- dimnames(result$residuals)
  result$slope <- with(result, unname(coef(lm(c(residuals) ~ c(compValue)))[2]))
  result$power <- 1 - result$slope
  result

}
