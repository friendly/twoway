## this is a major rewrite. I am not doing documentation yet.

#' Plot method for two-way tables
#' @importFrom graphics plot text abline arrows segments
#' @importFrom stats lm coef
#' @export

plot.twoway <- function(x,
                        which=c("fit", "diagnose"),
                        ...) {

  ## TODO: do both plots in a single call??

  switch(match.arg(which),
         fit=plot.twoway.fit(x, ...),
         diagnose=plot.twoway.diagnose(x, ...),
         stop("invalid 'which' value")
         )
}

plot.twoway.fit <-
  function(x,
           main=paste0("Tukey two-way fit plot for ", x$name, " (method: ", x$method, ")"),
           ylab="Fitted value",
           rfactor=1,
           rcolor=c("blue", "red"),
           ylim=NULL,
           ...) {
  roweff <- x$roweff
  coleff <- x$coleff
  r <- length(x$roweff)
  c <- length(x$coleff)
  all <- x$overall
  clo <- min(coleff) + all
  chi <- max(coleff) + all
  from <- cbind(clo - roweff, clo + roweff)
  to   <- cbind(chi - roweff, chi + roweff)

  rlo <- min(roweff)
  rhi <- max(roweff)
  from <- rbind(from,  cbind(coleff + all - rhi, coleff + all + rhi))
  to   <- rbind(to,    cbind(coleff + all - rlo, coleff + all + rlo))
  colnames(from) <- c("x", "y")
  colnames(to)   <- c("x", "y")

  labs <- c(names(roweff), names(coleff))

  ## find the plot range to include residuals and labels
  fit <- outer(x$roweff, x$coleff, "+") + x$overall
  dat <- fit + x$residuals
  dif <- t(outer(coleff+all, roweff,  "-"))  # colfit - roweff
  if (is.null(ylim)) {
    ylim <- range(rbind(dat, fit))
    ylim <- ylim + c(-.25, .1)* range(rbind(dat,fit))
  }
  ## coordinates of vertices in the plot are (fit, dif)
  plot( rbind(from, to), main=main, type="n",
       ##          col=rep(c("red", "blue"), times= c(r, c)),
       asp=1,
       ylim = ylim,
       ylab = ylab,
       xlab=" Column Fit - Row Effect",
       ...)


  indr <- 1:r
  indc <- (r+1):(r+c)
  ## labels for rows and columns
  ## TODO: tweak label positions with an offset
  off <- c(0, .5)
  text(to[indr,], labs[indr], srt=45, pos=4, offset=c(0.1,0.5), xpd=TRUE)
  text(to[(r+1):(r+c),], labs[(r+1):(r+c)], srt=-45, pos=4, offset=c(0,-.5), xpd=TRUE)
  ## draw lines
  segments(from[indr,1], from[indr,2], to[indr,1], to[indr,2])
  segments(from[indc,1], from[indc,2], to[indc,1], to[indc,2])

  ## draw lines/arrows for  large residuals
  ## TODO should use sqrt(SSPE)
  e <- x$residuals
  MSE <- sum(e^2) / prod(c(r,c)-1)
  sigma <- sqrt(MSE)
  showres <- abs(e) > rfactor * sigma
  clr <- ifelse(e > 0, rcolor[1], rcolor[2])
  ##    browser()


  ## DONE: vectorize this code !!!

  x.df <- as.data.frame(x)
  bot <- cbind(x.df$dif, x.df$fit)
  top <- cbind(x.df$dif, x.df$data)
  clr <- ifelse(x$residual > 0, rcolor[1], rcolor[2])
  segments(bot[,1], bot[,2], top[,1], top[,2], col = clr)

}


## diagnostic plot
plot.twoway.diagnose <-
  function(x,
           annotate=TRUE,
           ...) {

    plot(c(x$residual) ~ c(x$compValue),
         main=paste0("Tukey additivity plot for ", x$name, " (method: ", x$method, ")"),
         cex = 1.2,
         pch = 16,
         xlab = expression("Comparison Values = roweff * coleff /" * hat(mu)),
         ylab = sprintf("Residuals from %s ~ %s + %s",
                        x$responseName, x$varNames[1], x$varNames[2]),
         ...)
    abline(lm(c(x$residual) ~ c(x$compValue)), lwd=2)
    abline(h = 0, v = 0, lty = "dotted")
    cat("Slope of Residual on comparison value: ", round(x$slope,1),
        "\nSuggested power transformation:        ", round(x$power,1),
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
           pos=pos)
    }

    ## TODO: Identify unusual points
    ## TODO: Optionally, add confidence limits for lm line, or add loess smooth??

  }
