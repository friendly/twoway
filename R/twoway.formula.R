twoway.formula <- function(formula, data, subset, na.action, ...) {

  if (missing(formula) || !inherits(formula, "formula"))
    stop("'formula' missing or incorrect")
  if (length(formula) != 3L)
    stop("'formula' must have both left and right hand sides")
  tt <- if (is.data.frame(data))
    terms(formula, data = data)
  else terms(formula, allowDotAsName = TRUE)
  if (any(attr(tt, "order") > 1))
    stop("interactions are not allowed")

  rvar <- attr(terms(formula[-2L]), "term.labels")
  cvar <- attr(terms(formula[-3L]), "term.labels")
  rhs.has.dot <- any(rvars == ".")
  lhs.has.dot <- any(cvars == ".")
  if (lhs.has.dot && rhs.has.dot)
    stop("'formula' has '.' in both left and right hand sides")
  m <- match.call(expand.dots = FALSE)
  edata <- eval(m$data, parent.frame())

  # cl <- match.call()
  # mf <- match.call(expand.dots = FALSE)
  # m <- match(x = c("formula", "data", "subset", "weights", "na.action"),
  #            table = names(mf), nomatch = 0L)

}
