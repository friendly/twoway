# method suggested on https://stackoverflow.com/questions/50469320/how-to-write-a-formula-method-that-converts-long-to-wide

library(tibble)
library(tidyr)
library(dplyr)

twoway.formula <- function(formula, data, subset, na.action, ...) {

  if (missing(formula) || !inherits(formula, "formula"))
    stop("'formula' missing or incorrect")
  if (length(formula) != 3L)
    stop("'formula' must have both left and right hand sides")
  tt <- if (is.data.frame(data)) {
    terms(formula, data = data)
  } else { terms(formula) }
  if (any(attr(tt, "order") > 1))
    stop("interactions are not allowed")

  rvar <- attr(terms(formula[-2L]), "term.labels")
  lvar <- attr(terms(formula[-3L]), "term.labels")
  rhs.has.dot <- any(rvar == ".")
  lhs.has.dot <- any(lvar == ".")
  if (lhs.has.dot || rhs.has.dot)
    stop("'formula' cannot use '.' in left or right hand sides")
  m <- match.call(expand.dots = FALSE)
  edata <- eval(m$data, parent.frame())
  lhs <- formula[[2]]
  rhs <- formula[[3]]

  wide <-
    edata %>%
    select(one_of(rvar, lvar)) %>%
    spread(key = rvar[2], value = lvar) %>%
    column_to_rownames(rvar[1])
browser()
  # call the default method on the wide data set
  twoway(wide)
}
