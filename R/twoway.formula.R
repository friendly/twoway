#'
#' Formula method for twoway analysis using a dataset in long format
#'
#' The formula method reshapes the data set from long to wide format and calls the default method.
#'
#' @param formula A formula of the form \code{response ~ rowvar + colvar}, where \code{response} is numeric
#' @param data The name of the data set, containing a row vactor, column factor and a numeric response
#' @param subset An expression to subset the data (unused)
#' @param na.action What to do with NAs? (unused)
#' @param ... other arguments, passed down
#' @importFrom stats terms
#' @export
#' @references the conversion of long to wide in a formula method was suggested on
#'        \url{https://stackoverflow.com/questions/50469320/how-to-write-a-formula-method-that-converts-long-to-wide}
#' @examples
#' longRT <- to_long(taskRT)
#' twoway(RT ~ Task + Topic, data=longRT)

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
  if (length(rvar) != 2) stop("The 'formula' must have two variables on the right-hand side")
  if (length(lvar) != 1) stop("The 'formula' must have one variable on the left-hand side")
  rhs.has.dot <- any(rvar == ".")
  lhs.has.dot <- any(lvar == ".")
  if (lhs.has.dot || rhs.has.dot)
    stop("'formula' cannot use '.' in left or right hand sides")
  m <- match.call(expand.dots = FALSE)
  edata <- eval(m$data, parent.frame())
  # lhs <- formula[[2]]
  # rhs <- formula[[3]]

  wide <- to_wide(edata)
#browser()
  # call the default method on the wide data set
  twoway(wide, ...)
}

