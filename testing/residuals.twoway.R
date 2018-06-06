# Extractor methods for twoway objects


#' Extract residuals from a twoway object
#'
#' @param object A \code{class="twoway"} object
#' @param nonadd If \code{TRUE}, the 1 degree of freedom term for non-additivity is subtracted from the additive residuals
#' @param ... other arguments (unused)
#'
#' @return
#' @export
#'
#' @examples
#' # none yet
residuals.twoway <- function(object, nonadd=FALSE, ...) {
  resids <- object$residuals
  if (nonadd) resids <- resids - object$compValue
  resids
}

#' Extract fitted values from a twoway object
#'
#' @param object A \code{class="twoway"} object
#' @param nonadd If \code{TRUE}, the 1 degree of freedom term for non-additivity is added to the fit of the additive model
#' @param ... other arguments (unused)
#'
#' @return
#' @export
#'
#' @examples
#' # none yet
fitted.twoway <- function(object, nonadd=FALSE, ...) {
  fitted <- object$overall + outer(object$roweff, object$coleff)
  if (nonadd) fitted <- fitted + object$compValue
  fitted
}

