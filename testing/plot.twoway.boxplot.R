# boxplots for residuals in twoway tables

# TODO:  It would be nicer to label outliers in these plots.  Using graphics::boxplot, this requires
#     an additional call to text(), having first saved the result of `boxplot()`.
#     See: https://stackoverflow.com/questions/15181086/labeling-outliers-on-boxplot-in-r
#     `car::Boxplot()`may be easier`, but the way I use the argument `all=TRUE` may make both of these
#     more difficult.

#' Title
#'
#' @description Boxplots of the residuals are shown, possibly classified by the row and/or column factors
#'
#' @param x
#' @param main
#' @param by One or more of \code{c("row", "col", "all")}
#' @param all if \code{TRUE}, all residuals are shown in a separate boxplot
#' @param col color for boxplot central box
#' @param pch plotting character for outliers
#' @param ... other arguments passed down
#'
#' @export
#'
#' @examples
#' twAZ <- twoway(Arizona, method="median")
#' plot.twoway.boxplot(twAZ, by="row")
#' plot.twoway.boxplot(twAZ, by="row", all=TRUE)
#' plot.twoway.boxplot(twAZ, by="col", all=TRUE)
#' plot.twoway.boxplot(twAZ, by="all")

plot.twoway.boxplot <-
  function(x,
           main = paste0("Residuals for ", x$name, " (method: ", x$method, ")"),
           by = c("row", "col"),
           all = FALSE,
           col = "lightgray",
           pch = 16,
           ...) {
    res <- resids <- x$residuals
    if ("col" %in% by) {
      if (all) {
        res <- as.list(as.data.frame(resids))
        res$All <- c(resids)
      }
      boxplot(res, ylab="Residual", xlab=x$varNames[2],
              col=col, main=main, pch=pch, ...)
    }

    if ("row" %in% by) {
      if (all) {
        res <- as.list(as.data.frame(t(resids)))
        res$All <- c(resids)
      }
      boxplot(res, ylab="Residual", xlab=x$varNames[1],
              col=col, main=main, pch=pch, ...)
    }

    if ("all" %in% by)
        boxplot(c(resids), ylab="Residual",
                col=col, main=main, pch=pch, ...)
  }


