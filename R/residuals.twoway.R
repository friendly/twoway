# Extractor methods for twoway objects


#' Extract residuals from a twoway object
#'
#' @param object A \code{class="twoway"} object
#' @param nonadd If \code{TRUE}, the 1 degree of freedom term for non-additivity is subtracted from the additive residuals
#' @param ... other arguments (unused)
#'
#' @return A numeric matrix of residuals corresponding to the data supplied to \code{twoway}
#' @export
#' @rdname residuals
#'
#' @examples
#' data(taskRT)
#' task.2way <- twoway(taskRT)
#' residuals(task.2way)
#' residuals(task.2way, nonadd=TRUE)
#'
#' sum(residuals(task.2way)^2)               #  SSE for additive model
#' sum(residuals(task.2way, nonadd=TRUE)^2)  # SSPE, non-additive model

residuals.twoway <- function(object, nonadd=FALSE, ...) {
  resids <- object$residuals
  if (nonadd) resids <- resids - object$slope * object$compValue
  resids
}

#' Extract fitted values from a twoway object
#'
#' @param object A \code{class="twoway"} object
#' @param nonadd If \code{TRUE}, the 1 degree of freedom term for non-additivity is added to the fit of the additive model
#' @param ... other arguments (unused)
#'
#' @return A numeric matrix of fitted values corresponding to the data supplied to \code{twoway}
#' @export
#' @rdname residuals
#'
#' @examples
#' data(taskRT)
#' task.2way <- twoway(taskRT)
#' fitted(task.2way)
#' fitted(task.2way, nonadd=TRUE)
#'
fitted.twoway <- function(object, nonadd=FALSE, ...) {
  fitted <- object$overall + outer(object$roweff, object$coleff)
  if (nonadd) fitted <- fitted + object$slope * object$compValue
  fitted
}

