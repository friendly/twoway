#' ANOVA summary for a two-way table, including Tukey Additivity Test
#'
#' Test for a 1-df interaction in two-way ANOVA table by the Tukey test.
#'
#' @details Fits the additive model, the model adding the 1 df term for non-additivity, or both
#'   (the default), depending on \code{test}. The analysis is based on row and column means.
#'
#'   The non-additive model's ANOVA table already includes the Tukey test as its \code{nonadd}
#'   row. To instead see it as a direct comparison of the two fitted models, call \code{anova()}
#'   on the two components of the result, e.g. \code{anova(result$additive, result$nonadditive)}
#'   -- this reproduces the same F and p-value as the \code{nonadd} row.
#'
#' @param object a \code{class("twoway")} object
#' @param test one of \code{"both"}, \code{"add"}, \code{"nonadd"}: which model(s) to fit and
#'   report. \code{"add"} fits the additive model alone; \code{"nonadd"} fits the model that adds
#'   the 1 df term for non-additivity (the Tukey test, shown as the \code{nonadd} row);
#'   \code{"both"} (default) fits and reports both.
#' @param ... other arguments passed down, but not used here
#' @return An object of class \code{"anova.twoway"}: a named list of the fitted model(s)
#'   (\code{additive} and/or \code{nonadditive}, each an \code{"aov"} object, depending on
#'   \code{test}), with the dataset name and fitting method attached as attributes for the print
#'   method to report.
#' @references Tukey, J. W. (1949). One Degree of Freedom for Non-Additivity. \emph{Biometrics}, 5(3), 232-242.
#'   \doi{10.2307/3001938}
#' @author Michael Friendly
#' @importFrom stats anova aov reformulate
#' @export
#' @rdname anova.twoway
#' @examples
#' data(sentRT)
#' sent.2way <- twoway(sentRT)
#' anova(sent.2way)
#'
#' data(EastCoast)
#' EC.2way <- twoway(EastCoast)
#' anova(EC.2way)
#'
#' data(hstart)
#' hstart.2way <- twoway(hstart)
#' anova(hstart.2way)
#'
#' data(Arizona)
#' AR.2way <- twoway(Arizona)
#' anova(AR.2way)
#'
#' # just the additive-model ANOVA
#' anova(sent.2way, test = "add")
#'
#' # just the non-additive-model ANOVA -- the Tukey test is its `nonadd` row
#' result <- anova(sent.2way, test = "nonadd")
#' result$nonadditive
#'
#' # the same Tukey test, as a direct comparison of the two fitted models
#' both <- anova(sent.2way)
#' anova(both$additive, both$nonadditive)

anova.twoway <- function(object, test = c("both", "add", "nonadd"), ...) {

  test <- match.arg(test)
  if (object$method == "median") warning("The anova method is not appropriate for analysis by medians.\nThis analysis uses means.")

  z <- as.data.frame(object)
  vn <- object$varNames

  result <- list()

  if (test %in% c("both", "add")) {
    formula1 <- data ~ row + col
    ref1 <- reformulate(vn, formula1[[2]])
    result$additive <- aov(ref1, data=z)
  }

  if (test %in% c("both", "nonadd")) {
    formula2 <- data ~ row + col + nonadd
    ref2 <- reformulate(c(vn, "nonadd"), formula2[[2]])
    result$nonadditive <- aov(ref2, data=z)
  }

  attr(result, "name") <- object$name
  attr(result, "method") <- object$method
  class(result) <- "anova.twoway"
  result
}

#' Print method for \code{"anova.twoway"} objects
#'
#' @param x an object of class \code{"anova.twoway"}, from \code{\link{anova.twoway}}
#' @rdname anova.twoway
#' @export
print.anova.twoway <- function(x, ...) {

  cat(sprintf('Dataset: %s; method: "%s"\n\n', attr(x, "name"), attr(x, "method")))

  if (!is.null(x$additive)) {
    aov1 <- anova(x$additive)
    attr(aov1, "heading") <- "Analysis of Variance Table, assuming additivity\n"
    print(aov1, ...)
  }

  if (!is.null(x$additive) && !is.null(x$nonadditive)) cat("\n\n")

  if (!is.null(x$nonadditive)) {
    aov2 <- anova(x$nonadditive)
    rownames(aov2)[4] <- "pure error"
    attr(aov2, "heading") <- "Analysis of Variance Table, allowing non-additivity\n"
    print(aov2, ...)
  }

  invisible(x)
}
