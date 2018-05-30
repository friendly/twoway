#' Print method for two-way tables

#' @param x a numeric matrix
#' @param digits number of digits to print
#' @param border if 0, the components \code{"twoway"} object (\code{"overall", "roweff", "coleff", "residuals"}) are printed separately;
#'               if 1, the row, column and overall effects are joined to the residuals in a single table.
#'               if 2, row, column, overall and residuals are joined, and decorated with horizontal and vertical rules
#' @param zapsmall a logical value; if \code{TRUE} small residuals are printed as 0.
#' @param ... other arguments passed down
#' @author Michael Friendly, Richard Heiberger
#' @examples
#' data(taskRT)
#' task.2way <- twoway(taskRT)
#' print(task.2way)
#' print(task.2way, border=0)
#'
#' data(sentRT)
#' sent.2way <- twoway(sentRT)
#' print(sent.2way)
#' print(sent.2way, border=1)
#'
#' @export

print.twoway <-
  function (x, digits = getOption("digits"), border=2, zapsmall=TRUE, ...)
  {
    title <- switch(x$method,
                    mean="Mean decomposition ",
                    median="Median polish decomposition ",
                    "Initial data ")
    cat("\n", title, '(Dataset: "', x$name, '"; Response: ', x$responseName, ')\n', sep="")

    if (border < 1) {
      cat("\nOverall: ", x$overall, sep="")
      cat("\n\nRow Effects: ", x$varNames[1], "\n", sep = "")
      print(x$roweff, digits = digits, ...)
      cat("\nColumn Effects:\n")
      cat("\nColumn Effects: ", x$varNames[2], "\n", sep = "")
      print(x$coleff, digits = digits, ...)
      cat("\nResiduals:\n")
      resids <- if (zapsmall) zapsmall(x$residuals) else x$residuals
      print(resids, digits = max(2L, digits - 2L), ...)
    }
    else if (border == 1){
      cat("Residuals bordered by row effects, column effects, and overall\n\n")
      resids <- if (zapsmall) zapsmall(x$residuals) else x$residuals
      tbl <- rbind(
        cbind( resids, roweff=x$roweff ),
        coleff=    c( x$coleff, x$overall)
      )
      names(dimnames(tbl)) <- names(dimnames(resids))
      print(tbl, digits = max(2L, digits - 2L), ...)
    }
    else {
      cat("Residuals bordered by row effects, column effects, and overall\n\n")
      tbl <- rbind(cbind(x$residuals, roweff = x$roweff),
                   coleff = c(x$coleff,
                              x$overall))
      tblz <- if (zapsmall) zapsmall(tbl) else tbl
      tblf <- format(tblz, digits = max(2L, digits - 2L))
      nc <- nchar(tblf[1])
      hhyphen <- paste0(rep("-", nc), collapse = "")
      ddot <- paste0(rep(".", nc), collapse = "")
      tblr <- rbind(` ` = hhyphen, tblf[-nrow(tblf), ], ` ` = ddot,
                    coleff = tblf[nrow(tblf), ])
      vvertical <- c("+", rep("|", nrow(tbl) - 1), "+", "|")
      ccolon <- c("+", rep(":", nrow(tbl) - 1), "+", ":")
      tblc <- cbind(` ` = vvertical, tblr[, -ncol(tblr)], ` ` = ccolon,
                    roweff = tblr[, ncol(tblr)])
      names(dimnames(tblc)) <- names(dimnames(x$residuals))
      print(tblc, quote = FALSE, ...)
    }
    cat("\n")

    invisible(x)

  }

# print.twoway <-
#   function (x, digits = getOption("digits"), border=2, zapsmall=TRUE, ...)
#   {
#     title <- if(x$method == "mean")
#       "Mean decomposition "
#     else
#       "Median polish decomposition "
#     cat("\n", title, "(Dataset: \"", x$name, "\")\n", sep="")
#
#     if (border < 1) {
#       cat("\nOverall: ", x$overall, "\n\nRow Effects:\n", sep = "")
#       print(x$roweff, digits = digits, ...)
#       cat("\nColumn Effects:\n")
#       print(x$coleff, digits = digits, ...)
#       cat("\nResiduals:\n")
#       resids <- if (zapsmall) zapsmall(x$residuals) else x$residuals
#       print(resids, digits = max(2L, digits - 2L), ...)
#     }
#     else if (border == 1){
#       cat("Residuals bordered by row effects, column effects, and overall\n\n")
#       resids <- if (zapsmall) zapsmall(x$residuals) else x$residuals
#       tbl <- rbind(
#         cbind( resids, roweff=x$roweff ),
#         coleff=    c( x$coleff, x$overall)
#       )
#       print(tbl, digits = max(2L, digits - 2L), ...)
#     }
#     else {
#       cat("Residuals bordered by row effects, column effects, and overall\n\n")
#       tbl <- rbind(cbind(x$residuals, roweff = x$roweff),
#                    coleff = c(x$coleff,
#                               x$overall))
#       tblz <- if (zapsmall) zapsmall(tbl) else tbl
#       tblf <- format(tblz, digits = max(2L, digits - 2L))
#       nc <- nchar(tblf[1])
#       hhyphen <- paste0(rep("-", nc), collapse = "")
#       ddot <- paste0(rep(".", nc), collapse = "")
#       tblr <- rbind(` ` = hhyphen, tblf[-nrow(tblf), ], ` ` = ddot,
#                     coleff = tblf[nrow(tblf), ])
#       vvertical <- c("+", rep("|", nrow(tbl) - 1), "+", "|")
#       ccolon <- c("+", rep(":", nrow(tbl) - 1), "+", ":")
#       tblc <- cbind(` ` = vvertical, tblr[, -ncol(tblr)], ` ` = ccolon,
#                     roweff = tblr[, ncol(tblr)])
#       print(tblc, quote = FALSE, ...)
#     }
#     cat("\n")
#
#     invisible(x)
#
#   }
