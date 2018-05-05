# Functions for Tukey anslysis of two-way tables

#' Analysis of a two-way table
#'
#' Fits an additive model using either row and column means or Tukey's median polish procedure
#'
#' @param x a numeric matrix
#' @param ... other arguments passed down
#' @rdname twoway
#' @seealso code{\link[stats]{medpolish}}
#' @references Tukey, J. W. (1977). \emph{Exploratory Data Analysis}, Reading MA: Addison-Wesley.
#'             Friendly, M. (1991). \emph{SAS System for Statistical Graphics} Cary, NC: SAS Institute
#' @export

twoway <-
	function(x, ...) UseMethod("twoway")


#' @param x a numeric matrix
#' @param method one of \code{"mean"} or \code{"median"}
#' @param ... other arguments passed down
#' @rdname twoway
#' @method twoway default
#' @export
#' @result

twoway.default <- function(x, method=c("mean", "median"), ...) {

  method <- match.arg(method)
  if (method=="mean")
    result <- meanfit(x)
  else
    result <- medianfit(x, ...)
  result

}


## diagnostic plot for removable interaction, from stats::medpolish
plot.medpolish <-
function (x, main = "Tukey Additivity Plot", ...)
{
		comp <- outer(x$row, x$col)/x$overall
		res <- x$residuals
    plot(comp, x$residuals, main = main,
        xlab = "Diagnostic Comparison Values", ylab = "Residuals",
        ...)
    abline(lm(res ~ comp))
    abline(h = 0, v = 0, lty = "dotted")
}

#' Print method for two-way tables

#' @param x a numeric matrix
#' @param digits number of digits to print
#' @param ... other arguments passed down
#' @rdname twoway

print.twoway <-
function (x, digits = getOption("digits"), ...)
{
		title <- if(x$method == "mean")
			"Mean decomposition "
			else
			"Median polish decomposition "
		cat("\n", title, "(Dataset: \"", x$name, "\")\n", sep="")
    cat("\nOverall: ", x$overall, "\n\nRow Effects:\n", sep = "")
    print(x$row, digits = digits, ...)
    cat("\nColumn Effects:\n")
    print(x$col, digits = digits, ...)
    cat("\nResiduals:\n")
    print(x$residuals, digits = max(2L, digits - 2L), ...)
    cat("\n")
    invisible(x)
}

#' Plot method for two-way tables
#'
#' Plots either the fitted values and residuals under additivity or
#' a diagnostic plot for removable non-additivity
#' @param x a numeric matrix
#' @param type one of \code{"fit"} or \code{"diagnose"}
#' @param rfactor for the \code{"fit"} method, draw arrows for \code{abs(residuals) > rfactor*sqrt(MSPE)}
#' @param ... other arguments passed down
#' @rdname twoway

plot.twoway <- function(x, type=c("fit", "diagnose"), main,  rfactor=1.5, ...) {
	type <- match.arg(type)

	if(type=="fit") {
    if (missing(main)) main <- "Tukey two-way fit plot"
  	row <- x$row
  	col <- x$col
  	r <- length(row)
  	c <- length(col)
  	all <- x$overal
  	clo <- min(col) + all
  	chi <- max(col) + all
    from <- cbind(clo - row, clo + row)
    to   <- cbind(chi - row, chi + row)

    rlo <- min(row)
    rhi <- max(row)
    from <- rbind(from,  cbind(col + all - rhi, col + all + rhi))
    to   <- rbind(to,    cbind(col + all - rlo, col + all + rlo))
    colnames(from) <- c("x", "y")
    colnames(to)   <- c("x", "y")

    labs <- c(names(row), names(col))

    plot( rbind(from, to), main=main,
          col=rep(c("red", "blue"), times= c(r, c)),
          ...)

    text(to, labs, srt=rep(c(45, -45), c(r,c)))
	}
	else {
	  if (missing(main)) main <- "Tukey additivity plot"
	  comp <- outer(x$row, x$col)/x$overall
	  res <- x$residuals
	  plot(comp, x$residuals, main = main,
	       xlab = "Diagnostic Comparison Values", ylab = "Residuals",
	       ...)
	  abline(lm(res ~ comp))
	  abline(h = 0, v = 0, lty = "dotted")

	}
}
