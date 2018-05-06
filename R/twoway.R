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

#' Default method for two-way tables

#' @param method one of \code{"mean"} or \code{"median"}
#'
#' @rdname twoway
#' @method twoway default
#' @export
#' @return An object of class \code{"twoway"}
#' @seealso \code{\link{medianfit}}, \code{\link{meanfit}}
#' @example
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
#' @export

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
#' @param x a \code{class("twoway")} object
#' @param type one of \code{"fit"} or \code{"diagnose"}
#' @param main plot title
#' @param ylab Y axis label for \code{"fit"} plot
#' @param rfactor for the \code{"fit"} method, draw arrows for \code{abs(residuals) > rfactor*sqrt(MSPE)}
#' @param ... other arguments passed down
#' @importFrom graphics plot text abline
#' @importFrom stats lm
#' @export

plot.twoway <- function(x, type=c("fit", "diagnose"), main, ylab, rfactor=1.5, ...) {
	type <- match.arg(type)

	if(type=="fit") {
    if (missing(main)) main <- paste("Tukey two-way fit plot for", x$name)
    if (missing(ylab)) ylab <- "Fitted value"
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

    # find the plot range to include residuals and labels
    fit <- outer(x$row, x$col, "+") + x$overall
    dat <- fit + x$residuals
    ylim <- range(rbind(dat, fit))
    ylim <- ylim + c(-.1, .1)* range(rbind(dat,fit))

    plot( rbind(from, to), main=main,
          col=rep(c("red", "blue"), times= c(r, c)),
          asp=1,
          ylim = ylim,
          ylab = ylab,
          xlab="Row Effect - Column Fit",
          ...)


    indr <- 1:r
    indc <- (r+1):(r+c)
    # labels for rows and columns
    # TODO: tweak label positions with an offset
    text(to[indr,], labs[indr], srt=45, pos=4)
    text(to[(r+1):(r+c),], labs[(r+1):(r+c)], srt=-45, pos=4)
    # draw lines
    segments(from[indr,1], from[indr,2], to[indr,1], to[indr,2])
    segments(from[indc,1], from[indc,2], to[indc,1], to[indc,2])
    # draw large residuals
	}
  # diagnostic plot
	else {
	  if (missing(main)) main <- paste("Tukey additivity plot for", x$name)
	  comp <- c(outer(x$row, x$col)/x$overall)
	  res <- c(x$residuals)
	  plot(comp, x$residuals, main = main,
	       xlab = "Diagnostic Comparison Values",
	       ylab = "Residuals",
	       ...)
	  abline(lm(res ~ comp))
	  abline(h = 0, v = 0, lty = "dotted")
	  # TODO: Identify unusual points
	  # TODO: Optionally, add confidence limits for lm line, or add loess smooth??


	}
}
