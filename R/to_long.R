#' Reshape a data.frame or matrix to a long data.frame
#'
#'
#' @param wide A data.frame or matrix in wide form
#' @param rowname Name for the row variable
#' @param colname Name for the column variable
#' @param responseName Name for the response variable.  If \code{wide} is a matrix with an attribute that begins with
#'       \code{"response"}, that value is taken as the \code{responseName}.  Otherwise, the name of the \code{wide}
#'       object is used.
#' @param varNames Default names for the row and column variables if not passed as \code{rowname} or \code{colname}
#' @return A data.frame in long format
#' @rdname to_long
#' @export
#' @examples
#' Arizona.long <- to_long(Arizona, varNames=c("Month", "City"))
#' Arizona.long
#'
to_long <- function(wide,
                    rowname=NULL, colname=NULL,
                    responseName=deparse(substitute(wide)),
                    varNames=c("Row","Col")) {
  # if wide is a matrix, try to get attributes from it directly
  if (is.matrix(wide)) {
      if(!is.null(attr(wide, "response"))) responseName <- attr(wide, "response")
      if(!is.null(names(dimnames(wide)))) varNames <- names(dimnames(wide))
  }
  result <- as.data.frame.table(data.matrix(wide),
                                responseName=responseName)
  if (!is.null(rowname)) varnames[1] <- rowname
  if (!is.null(colname)) varnames[2] <- colname
  names(result)[1:2] <- varNames
  result
}


#' Reshape a data.frame or matrix to a wide data.frame
#'
#' @param long A data.frame in long form
#' @param row Column index or quoted name of the row variable
#' @param col Column index or quoted name of the column variable
#' @param response Column index or quoted name of the response variable
#' @rdname to_long
#' @export

to_wide <- function(long, row=1, col=2, response=3)	{
  tapply(long[,response], long[,c(row, col)], c)
}
