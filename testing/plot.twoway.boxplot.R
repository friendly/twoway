# boxplots for residuals in twoway tables

# TODO:  It would be nicer to label outliers in these plots.  Using graphics::boxplot, this requires
#     an additional call to text(), having first saved the result of `boxplot()`.
#     See: https://stackoverflow.com/questions/15181086/labeling-outliers-on-boxplot-in-r
#     `car::Boxplot()` may be easier, but the way I use the argument `all=TRUE` may make both of these
#     more difficult.

#' Title
#'
#' @description Boxplots of the residuals are shown, possibly classified by the row and/or column factors
#'
#' @param x
#' @param main
#' @param by One of \code{c("row", "col", "all")}
#' @param all if \code{TRUE}, all residuals are shown in a separate boxplot next to those for rows or columns
#' @param col color for boxplot central box
#' @param pch plotting character for outliers
#' @param ... other arguments passed down to \code{boxplot}
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
           by = c("row", "col", "all"),
           all = FALSE,
           col = gray(.85),
           pch = 16,
           ...) {
    res <- resids <- x$residuals
    by <- match.arg(by)
    if (by == "col") {
        res <- as.list(as.data.frame(resids))
        if (all) {
        res$All <- c(resids)
      }
      boxplot(res, ylab="Residual", xlab=x$varNames[2],
              col=col, main=main, pch=pch, ...)
    }

    if (by == "row") {
      res <- as.list(as.data.frame(t(resids)))
      if (all) {
        res$All <- c(resids)
      }
      boxplot(res, ylab="Residual", xlab=x$varNames[1],
              col=col, main=main, pch=pch, ...)
    }

    if (by == "all") {
        boxplot(c(resids), ylab="Residual",
                col=col, main=main, pch=pch, ...)
    }
  }


