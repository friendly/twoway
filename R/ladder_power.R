#' Find the nearest ladder-of-powers representation of a power transformation
#'
#' The input power value is rounded to the nearest integer or fractional powers, \eqn{\pm 1/3, 1/2}
#'
#' @param p A numeric power, for use as a transformation of a response, y, of the form \eqn{y^p},
#'          where \code{p=0} is interpreted to mean \eqn{log(y)}
#' @return a named list of two elements: \code{power}, the ladder-of-power value, and
#'         \code{name}, the name for the transformation
#' @examples
#' ladder_power(0.6)
#' ladder_power(-0.6)

ladder_power <- function (p){
  if (!is.numeric(p)) stop("The input power must be numeric")
	powers <- c(-3:-1, -0.5, -0.333,  0, 0.333, 0.5, 1:3)
	names <- c("reciprocal cube", "reciprocal square", "reciprocal", "reciprocal root", "reciprocal cube root",
	           "log",
	           "cube root", "square root", "no transformation", "square", "cube")
	index <- which.min( abs(p - powers) )
	power <- powers[index]
	name <- names[index]
#	if (power == 0) func = function(x) log(x)
#	else if (power > 0) {
#		func <- function(x) x^power
#	}
#	else {
#		func <- function(x) -(x^power)
#	}
	result <- list(power=power, name=name)
	result
}
