#' Initial sketch for a twoway formula method
#'
#' Doesn't do anything useful yet, but the idea is to be able to use a
#' formula for a twoway table in long form, e.g.,
#' twoway(response ~ row + col, data=mydata)
#'
#' @param formula A formula of the form \code{response ~ rowvar + colVAR}
#' @param data The name of the data set
#' @param subset An expression to subset the data (unused)
#' @param na.action What to do with NAs? (unused)
#' @param ... other arguments, passed down
#' @importFrom stats terms
#'
twoway.formula <- function(formula, data, subset, na.action, ...) {

  if (missing(formula) || !inherits(formula, "formula"))
    stop("'formula' missing or incorrect")
  if (length(formula) != 3L)
    stop("'formula' must have both left and right hand sides")
  tt <- if (is.data.frame(data))
    terms(formula, data = data)
  else terms(formula)
  if (any(attr(tt, "order") > 1))
    stop("interactions are not allowed")

  rvar <- attr(terms(formula[-2L]), "term.labels")
  lvar <- attr(terms(formula[-3L]), "term.labels")
  rhs.has.dot <- any(rvar == ".")
  lhs.has.dot <- any(lvar == ".")
  if (lhs.has.dot || rhs.has.dot)
    stop("'formula' has '.' in left or right hand sides")
  m <- match.call(expand.dots = FALSE)
  edata <- eval(m$data, parent.frame())
  lhs <- formula[[2]]
  rhs <- formula[[3]]

  #  wide <- dcast(data=edata, formula=as.formula(rhs), value.var=lhs )
  #  Wide <- dcast(data=edata, value.var=lhs)
  #  Wide <- dcast(data=edata, rvar[1] ~ rvar[2], value.var=cvar)
  #  wide <- dcast(data=edata, list(.(rvar[1], .(rvar[2], .(cvar)))))
browser()
  stop("The formula method is not yet implemented.")

  # cl <- match.call()
  # mf <- match.call(expand.dots = FALSE)
  # m <- match(x = c("formula", "data", "subset", "weights", "na.action"),
  #            table = names(mf), nomatch = 0L)

}
