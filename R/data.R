#' Data on reaction times for various tasks and topics
#'
#' A demonstration 3 x 4 two-way table composed of reaction times for
#' tasks varying in difficulty, with content on different topics.
#'
#' @name taskRT
#' @docType data
#' @keywords data
#' @format A matrix of 3 rows and 4 columns, where the rows are the task difficulty levels and the columns are the the topics.
#'        The cell values are average reaction times (in sec.). The matrix has a \code{responseName} attribute, \code{"RT"}
#' @examples
#' data(taskRT)
#' twoway(taskRT)
#' twoway(taskRT, method="median")
NULL

#'  Reaction times for T/F judgments
#'
#' A demonstration 3 x 3 two-way table composed of reaction times for
#' three subjects making T/F judgments on three types of sentences
#'
#' @name sentRT
#' @docType data
#' @keywords data
#' @references Friendly, M. (1991). \emph{SAS System for Statistical Graphics} Cary, NC: SAS Institute, Table 7.2
#' @examples
#' data(sentRT)
#' twoway(sentRT)
NULL


#' Scores for 5 subjects after being given each of 4 drugs
#'
#' The original source is Winer (1971), p. 268.  This was used as an example in Friendly (1991).
#'
#' @name drugs
#' @docType data
#' @keywords data
#' @references Friendly, M. (1991). \emph{SAS System for Statistical Graphics} Cary, NC: SAS Institute, Output 7.28
#' @examples
#' data(drugs)
#' twoway(drugs)
NULL


#' Mean monthly temperatures in Arizona
#'
#' This is the data set used by Tukey (1977) for the initial examples of twoway tables
#' @name Arizona
#' @docType data
#' @keywords data
#' @format a matrix of 7 rows (Month) and 3 columns (City) where the value is mean
#'       monthly temperature in degrees F. The matrix has a \code{responseName} attribute, \code{"Temperature"}
#' @references Tukey, J. W. (1977). \emph{Exploratory Data Analysis}, Reading MA: Addison-Wesley. Exhibit 1 of chapter 10, p. 333
#' @examples
#' data(Arizona)
#' (AR.2way <-twoway(Arizona, method="median"))
#'
#' ## plot(AR.2way)
NULL

#' Counts of an insect for the combinations of 4 treatments and 6 areas of a field
#'
#' Counts of numbers of an insect, \emph{Leptinotarsa decemlineata} (the
#' Colorado potato beetle), each of which is the sum for two plots treated
#' alike, for all combinations of 4 treatments and 6 areas of the field chosen
#' to be relatively homogeneous.
#'
#' These data are used in Tukey (1977) Exhibit 1 of Ch 11 and throughout the chapter as examples of
#' median polish. Because the data are counts, either a sqrt or log transformation would be
#' reasonable.

#' @name insectCounts
#' @docType data
#' @keywords data
#' @format a 4 x 6 matrix, where the rows are treatments and the columns are areas of a field.
#' @references Tukey, J. W. (1977). \emph{Exploratory Data Analysis}, Reading MA: Addison-Wesley. Exhibit 1 of chapter 111
#' @examples
#' insect.2way <- twoway(insectCounts, method="median")
#' print(insect.2way, digits=2)
#'
#' plot(insect.2way)
#' plot(insect.2way, which="diagnose")
#'
#' # try sqrt transformation
#' insect.sqrt <- twoway(sqrt(insectCounts), method="median")
#' print(insect.sqrt, digits=2)
#'
#' plot(insect.sqrt)
#' plot(insect.sqrt, which="diagnose")

NULL

#' Number of U.S. housing starts by month for the years 1965 -- 1973
#'
#' @name hstart
#' @docType data
#' @keywords data
#' @format a 9 x 12 matrix, where the entries are the number of housing starts, in thousands
#' @references Becker, Chambers & Wilks (1988), \emph{The New S Language}, Brooks Cole.
#'             Friendly, M. (1991). \emph{SAS System for Statistical Graphics} Cary, NC: SAS Institute, p.380
#' @examples
#' hstart.2way <- twoway(hstart, method="mean")
#' plot(hstart.2way)

NULL

#' Vermont country populations from the US Census, 1900-1990
#'

#' @references Morgenthaler, Stephan, and John W. Tukey. “Multipolishing and Two-Way Plots.” Metrika 53.3 (2001): 245–267.

#' @examples
#' options(digits=4)
#' VP <- twoway(VermontPop,
#'              method="median",
#'              responseName = "log Population")
#' VP
#' plot(VP)

"VermontPop"

#' Compressibility of Rubber
#'
#' The specific volume of natural rubber was measured at four values of temperature and six values of pressure.
#' Is there any evidence that volume is not an additive relation with temperature and pressure?
#'
#' @name Rubber
#' @docType data
#' @keywords data
#' @format a 4 x 6 matrix, where the cell values are the specific volume (in cubic centimeters per gram)
#'         of peroxide-cured rubber. The row and column variables are:
#'  \itemize{
#'      \item{Temperature}, in degrees Celcuis
#'      \item{Pressure}, in kg / cm^2 above atmospheric pressure.
#'  }
#' @source
#'      Wood, L. A. & Martin, G. M. (1964). "Compressibility of natural rubber at pressures below
#'      500kg/cm^2",  Journal of Research of the National Standards Bureau--A. Physics & Chemistry,
#'      **68A**, 259--268.
#' @references
#'
#'      Emerson, J. D. & Wong, G. Y. (1985). "Resistant Nonadditve Fits for Two-Way Tables".
#'      In Hoaglin, D. C., Mosteller, F., & Tukey, J. W. (Eds.). Exploring data tables, trends and shapes. John Wiley Sons.
#'      Ch. 3, Table 3.1.
#' @examples
#' Rubber
#' # scale the response to avoid small decimals
#' rub <- 10000*Rubber
#' rubfit <- twoway(rub, "median")
#' plot(rubfit)

"Rubber"
