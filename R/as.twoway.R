#' Create an initial twoway object representing the data before fitting
#'
#' @param x a numeric matrix or numeric data frame with rownames
#' @param ... other arguments, unused here
#' @author Richard M. Heiberger
#' @rdname as.twoway
#' @return An object of class \code{c("twoway")} with all effects(roweff, coleff, overall) set to zero, and \code{method="Initial"}
#' @export

as.twoway <- function(x, ...) UseMethod("as.twoway")


#' Method for matrix input
#'
#' @param x a numeric matrix or numeric data frame with rownames
#' @param ... other arguments, unused here
#' @param name Name of the data matrix
#' @param responseName Name of the response variable
#' @param varNames Names of the row and column variables
#' @author Richard M. Heiberger
#' @rdname as.twoway
#'
#' @export
#'
#' @examples
#' data(taskRT)
#' as.twoway(taskRT)
#'
as.twoway.matrix <- function(x, ...,
                             name=deparse(substitute(x)),
                             responseName=name,    # TODO: perhaps the default should just be "Value"
                             varNames=names(dimnames(x))) {
  if (length(varNames) != 2) varNames <- c("Row", "Col")
  if(!is.null(attr(x, "response"))) responseName <- attr(x, "response") else responseName <- "Value"
  structure(.Data=list(overall=0,
                       roweff=rep(0, nrow(x)),
                       coleff=rep(0, ncol(x)),
                       residuals=x,
                       name=name,
                       rownames=rownames(x),
                       colnames=colnames(x),
                       method="Initial",
                       varNames=varNames,
                       responseName=responseName,
                       compValue=x,
                       slope=0,
                       power=1),
            class="twoway")
}
