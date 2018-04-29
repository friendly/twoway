# Functions for Tukey anslysis of two-way tables
twoway <-
	function(x, ...) UseMethod("twoway")

twoway.default <- function(x, method=c("mean", "median"), ...) {

  method <- match.arg(method)
  if (method=="mean")
    result <- meanfit(x)
  else
    result <- medianfit(x)
  
  result
  
}


medianfit <- function(x, trace.iter=FALSE, ...) {
	result <- stats::medpolish(x, trace.iter=trace,.ter, ...)
	result$rownames <- rownames(x)
	result$colnames <- colnames(x)
	result$name <-  deparse(substitute(x))
#	result$roweff <- result$row - result$overall
#	result$coleff <- result$col - result$overall
	result$method <- "median"
  class(result) <- c("twoway", "medpolish")
	result
	}

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

## diagnostic plot for removable interaction
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


print.twoway <-
function (x, digits = getOption("digits"), ...) 
{
		title <- if(x$method == "mean") 
			"Mean decomposition "
			else
			"Median polish decomposition "
			
#    cat("\nMedian Polish Results (Dataset: \"", x$name, "\")\n", 
#        sep = "")
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



plot.twoway <- function(x, type=c("fit", "diagnose"), rfactor=1.5, ...) {
	type <- match.arg(type)
	
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
  
  plot( rbind(from, to) , col=rep(c("red", "blue"), times= c(r, c)))
}