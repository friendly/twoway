#' ANOVA summary for a two-way table, including Tukey Additivity Test
#'
#' Test for a 1-df interaction in two-way ANOVA table by the Tukey test.
#'
#' @details At present, this function simply gives the results of the ANOVAs for the additive model, the model including the 1 df
#'          term for non-additivity, and an \code{anova()} comparison of the two.
#' @param x a \code{class("twoway")} object
#' @param ... other arguments passed down, but not used here
#' @author Michael Friendly
#' @export
#' @examples
#' data(sentRT)
#' sent.2way <- twoway(sentRT)
#' anova(sent.2way)


anova.twoway <- function(x, ...) {

  # r <- length(x$row)
  # c <- length(x$col)
  #
  # fit <- outer(x$row, x$col, "+") + x$overall
  # dat <- fit + x$residuals
  #
  # sse <- sum(x$residuals^2)
  # dfe <- ( r - 1 ) * ( c - 1 )
  #
  # ssrow <- c * sum(x$row^2)
  # sscol <- r * sum(x$col^2)

  z <- as.data.frame(x)
  aov1 <- anova(mod1 <- aov(data ~ row + col, data=z))
  aov2 <- anova(mod2 <- aov(data ~ row + col + nonadd, data=z))
  aov3 <- anova(mod1, mod2)

  info <- paste0('(Dataset: ', '"', x$name, '"; ', 'method: "', x$method, '")')
  cat("Additive model", info, "\n")
  print(aov1)

  cat("\nNon-Additive model", info, "\n")
  print(aov2)

  cat("\nTukey test for non-additivity\n")
  anova(mod1, mod2)
}
