#' Plot methods for two-way tables
#'
#' Plots either the fitted values and residuals under additivity or
#' a diagnostic plot for removable non-additivity by a power transformation
#'
#' @details For the \code{which="fit"} plot, the basic result comes from a plot of the row effects against the column fitted
#'     values, which appears as a rectangular grid in these coordinates.  Rotating this 45 degrees counterclockwise give a plot
#'     in which the vertical coordinate is the fitted value for the two-way table, and the horizontal coordinate is the column fit
#'     minus the row effect.  The spacing of the grid lines for the rows and columns of the table show the relative magnitudes of the
#'     row/column means or medians.
#'
#'     For the \code{which="diagnose"} plot, the interaction residuals from an additive model, \eqn{y_{ij} = \mu + \alpha_i + \beta_j},
#'     are plotted against the estimated components \eqn{\alpha_i \beta_j / \mu}. If this plot shows a substantially non-zero
#'     slope, \eqn{b}, this analysis suggests that a power transformation, \eqn{ y \rightarrow y^(1-b)} might reduce the
#'     apparent interaction effects.
#' @param x a \code{class("twoway")} object
#' @param which one of \code{"fit"} or \code{"diagnose"}
#' @param ...  other arguments, passed to \code{plot}
#' @param na.rm logical. Should missing values be removed?
#'
#' @importFrom graphics plot text abline arrows segments
#' @importFrom stats lm coef
#' @rdname plot.twoway
#' @export
#' @examples
#' data(taskRT)
#' tw <- twoway(taskRT)
#' tw
#' twmed <- twoway(taskRT, method="median")
#' twmed

#' plot(tw,    xlim=c(2,7), ylim=c(2,7)) ## use the same xlim and ylim, for comparison
#' plot(twmed, xlim=c(2,7), ylim=c(2,7))
#'
#' plot(tw,    which="diagnose", xlim=c(-.19, .19), ylim=c(-.5, .55))
#' plot(twmed, which="diagnose", xlim=c(-.19, .19), ylim=c(-.5, .55))
#'
#' data(insectCounts)
#' twi <- twoway(insectCounts)
#' twimed <- twoway(insectCounts, method="median")
#'
#' plot(twi,    xlim=c(-250, 700), ylim=c(-180, 900))
#' plot(twimed, xlim=c(-250, 700), ylim=c(-180, 900))
#'
#' plot(twi,    which="diagnose", xlim=c(-160, 170), ylim=c(-200, 400))  ## power = .1
#' plot(twimed, which="diagnose", xlim=c(-160, 170), ylim=c(-200, 400))  ## power = .3
#'


plot.twoway <- function(x,
                        which=c("fit", "diagnose"),
                        ..., na.rm=any(is.na(x$residuals))) {

  ## TODO: do both plots in a single call??

  switch(match.arg(which),
         fit=plot.twoway.fit(x, ..., na.rm=na.rm),
         diagnose=plot.twoway.diagnose(x, ...),
         stop("invalid 'which' value")
         )
}



## New plot.twoway.fit [RMH]

#' @param main plot title
#' @param xlab X axis label
#' @param ylab Y axis label
#' @param rfactor draw lines for \code{abs(residuals) > rfactor*sqrt(MSPE)}
#' @param rcolor  a vector of length 2 giving the color of lines for positive and negative residuals
#' @param lwd line width for residual lines in the fit plot
#' @param ylim Y axis limits
#'
#' @rdname plot.twoway
#'
plot.twoway.fit <-
  function(x,
           main=paste0("Tukey two-way fit plot for ", x$name, " (method: ", x$method, ")"),
           xlab=expression(hat(mu) * " + Column Effect - Row Effect"),
           ylab=expression("Fit = " * hat(mu) * " + Column Effect + Row Effect"),
           rfactor=1,
           rcolor=c("blue", "red"),
           lwd=3,
           ylim=NULL,
           ...,
           na.rm=any(is.na(x$residuals))) {

    CRA <- function(C, R, A) (A+R) + matrix(C, byrow=TRUE, nrow=length(R), ncol=length(C))

    ## all points
    ColPlusRow <-  CRA(x$coleff,  x$roweff, x$overall)
    ColMinusRow <- CRA(x$coleff, -x$roweff, x$overall)
    if (is.null(ylim)) {
      ylim <- range(ColPlusRow, na.rm=na.rm) + range(x$residuals, na.rm=na.rm)
      ylim <- ylim + c(-.02, .02)* diff(ylim)
    }
    plot(c(ColMinusRow), c(ColPlusRow),
         asp=1, xlab=xlab, ylab=ylab, main=main,
         ylim=ylim, ..., type="n")

    ## Row grid lines
    Rgridy <- CRA(range(x$coleff, na.rm=na.rm),  x$roweff, x$overall)
    Rgridx <- CRA(range(x$coleff, na.rm=na.rm), -x$roweff, x$overall)
    segments(Rgridx[,1], Rgridy[,1], Rgridx[,2], Rgridy[,2])

    ## Col grid lines
    Cgridy <- CRA(x$coleff,  range(x$roweff, na.rm=na.rm), x$overall)
    Cgridx <- CRA(x$coleff, -range(x$roweff, na.rm=na.rm), x$overall)
    segments(Cgridx[1,], Cgridy[1,], Cgridx[2,], Cgridy[2,])

    ## labels
    text(Rgridx[,2], Rgridy[,2], names(x$roweff), srt=45,  pos=4, offset=0.3, xpd=TRUE)
    text(Cgridx[1,], Cgridy[1,], paste0("\n\n",names(x$coleff)), srt=-45, pos=4, offset=0.7, xpd=TRUE)

    ## Row varName
    xmin <- which(min(Rgridx[,2], na.rm=na.rm) == Rgridx[,2])
    xmax <- which(max(Rgridx[,2], na.rm=na.rm) == Rgridx[,2])
    text(Rgridx[xmin, 2] + .95*diff(Rgridx[c(xmin, xmax), 2]),
         Rgridy[xmin, 2] + .25*diff(Rgridy[c(xmin, xmax), 2]), x$varNames[1])

    ## Col varName
    ymin <- which(min(Cgridy[2,], na.rm=na.rm) == Cgridy[2,])
    ymax <- which(max(Cgridy[2,], na.rm=na.rm) == Cgridy[2,])
    text(Cgridx[1, ymin] + .95*diff(Cgridx[1, c(ymin, ymax)]),
         Cgridy[1, ymin] + .25*diff(Cgridy[1, c(ymin, ymax)]), x$varNames[2])

    ## Residuals
    segments(c(ColMinusRow), c(ColPlusRow), c(ColMinusRow), c(ColPlusRow + x$residuals),
             col = rcolor[(x$residuals < 0) + 1],
             lwd=lwd, xpd=TRUE)

           }



## diagnostic plot

#' @details
#'      For both plots, if you want to directly compare the result of \code{method="mean"} and \code{method="median"}, it is
#'      essential to set the same \code{xlim} and \code{ylim} axes in the call.
#'
#' @param annotate  A logical value; if \code{TRUE}, the slope and power are displayed in the diagnostic plot
#' @param jitter    A logical value; if \code{TRUE}, the comparison values in the plot are jittered to avoid overplotting
#' @param smooth    A logical value; if \code{TRUE}, a smoothed \code{\link[stats]{loess}} curve is added to the plot
#' @param pch       Plot character for point symbols in the diagnostic plot
#'
#' @importFrom graphics lines
#' @importFrom stats loess.smooth
#' @return The diagnostic plot invisibly returns a list with elements \code{c("slope", "power")}
#' @rdname plot.twoway
#'
plot.twoway.diagnose <-
  function(x,
           annotate=TRUE,
           jitter=FALSE,
           smooth=FALSE,
           pch=16,
           ...) {

#    x$compValue <- outer(x$roweff, x$coleff)/x$overall

    cval <- if (jitter) jitter(c(x$compValue)) else c(x$compValue)
    plot(c(x$residual) ~ cval,
         main=paste0("Tukey additivity plot for ", x$name, " (method: ", x$method, ")"),
         cex = 1.2,
         pch = pch,
         xlab = expression("Comparison Values = roweff * coleff /" * hat(mu)),
         ylab = sprintf("Residuals from %s ~ %s + %s",
                        x$responseName, x$varNames[1], x$varNames[2]),
         ...)
    abline(lm(c(x$residual) ~ c(x$compValue)), lwd=2, col="blue")
    abline(h = 0, v = 0, lty = "dotted")
    if (smooth) lines(loess.smooth(c(x$compValue), c(x$residuals)), col="red")

    lpower <- ladder_power(x$power)
    cat("Slope of Residual on comparison value: ", round(x$slope,1),
        "\nSuggested power transformation:        ", round(x$power,1),
        "\nLadder of powers transformation:       ", lpower$name,
        "\n")

    if (is.logical(annotate) && annotate) {
      if( x$slope > 0 ) {
        loc <- c(min(x$compValue), .95*max(x$residual))
        pos=4
      }
      else {
        loc <- c(max(x$compValue), .95*max(x$residual))
        pos=2
      }

      text(loc[1], loc[2],
           paste("Slope:", round(x$slope,1), "\nPower:", round(x$power,1)),
           pos=pos, xpd=TRUE)
    }

    ## TODO: Identify unusual points
    ## TODO: Optionally, add confidence limits for lm line, or add loess smooth??

  }

## Michael Friendly, original plot.twoway.fit (modified)
# plot.twoway.fitMF <-
#   function(x,
#            main=paste0("Tukey two-way fit plot for ", x$name, " (method: ", x$method, ")"),
#            xlab=" Column Fit - Row Effect",
#            ylab="Fitted value",
#            rfactor=1,
#            rcolor=c("blue", "red"),
#            lwd=3,
#            ylim=NULL,
#            ...) {
#     roweff <- x$roweff
#     coleff <- x$coleff
#     r <- length(x$roweff)
#     c <- length(x$coleff)
#     all <- x$overall
#     clo <- min(coleff) + all
#     chi <- max(coleff) + all
#     from <- cbind(clo - roweff, clo + roweff)
#     to   <- cbind(chi - roweff, chi + roweff)
#
#     rlo <- min(roweff)
#     rhi <- max(roweff)
#     from <- rbind(from,  cbind(coleff + all - rhi, coleff + all + rhi))
#     to   <- rbind(to,    cbind(coleff + all - rlo, coleff + all + rlo))
#     colnames(from) <- c("x", "y")
#     colnames(to)   <- c("x", "y")
#
#     labs <- c(names(roweff), names(coleff))
#
#     ## find the plot range to include residuals and labels
#     fit <- outer(x$roweff, x$coleff, "+") + x$overall
#     dat <- fit + x$residuals
#     dif <- t(outer(coleff+all, roweff,  "-"))  # colfit - roweff
#     if (is.null(ylim)) {
#       ylim <- range(rbind(dat, fit))
#       ylim <- ylim + c(-.05, .05)* diff(ylim)
#     }
#     ## coordinates of vertices in the plot are (fit, dif)
#     plot( rbind(from, to), main=main, type="n",
#           ##          col=rep(c("red", "blue"), times= c(r, c)),
#           asp=1,
#           ylim = ylim,
#           ylab = ylab,
#           xlab = xlab,
#           ...)
#
#
#     indr <- 1:r
#     indc <- (r+1):(r+c)
#     ## labels for rows and columns
#     ## TODO: tweak label positions with an offset
#     off <- c(0, .5)
#     text(to[indr,], labs[indr], srt=45, pos=4, offset=c(0.1,0.5), xpd=TRUE)
#     text(to[(r+1):(r+c),], labs[(r+1):(r+c)], srt=-45, pos=4, offset=c(0,-.5), xpd=TRUE)
#     ## draw lines
#     segments(from[indr,1], from[indr,2], to[indr,1], to[indr,2])
#     segments(from[indc,1], from[indc,2], to[indc,1], to[indc,2])
#
#     ## draw lines/arrows for  large residuals
#     ## TODO should use sqrt(SSPE)
#     e <- x$residuals
#     MSE <- sum(e^2) / prod(c(r,c)-1)
#     sigma <- sqrt(MSE)
#     showres <- abs(e) > rfactor * sigma
#     clr <- ifelse(e > 0, rcolor[1], rcolor[2])
#     ##    browser()
#
#
#     ## DONE: vectorize this code !!!
#
#     x.df <- as.data.frame(x)
#     bot <- cbind(x.df$dif, x.df$fit)
#     top <- cbind(x.df$dif, x.df$data)
#     clr <- ifelse(x$residual > 0, rcolor[1], rcolor[2])
#     segments(bot[,1], bot[,2], top[,1], top[,2], col = clr, lwd=lwd)
#
#   }
#
