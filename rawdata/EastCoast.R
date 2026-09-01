# Exhibit 9 of chapter 10 ("East Coast" / "Warming up on the East Coast"),
# panel A) The DATA -- monthly mean temperatures in degrees F, for Laredo,
# Washington, and Caribou. Extracted from rawdata/EastCoast-scan.pdf.

EastCoast <- matrix(
  c(57.6, 36.2,  8.7,
    61.9, 37.1,  9.8,
    68.4, 45.3, 21.7,
    75.9, 54.4, 34.7,
    81.2, 64.7, 48.5,
    85.8, 73.4, 58.4,
    87.7, 77.3, 64.0),
  nrow = 7, ncol = 3, byrow = TRUE,
  dimnames = list(
    Month = c("Jan", "Feb", "Mar", "Apr", "May", "June", "July"),
    City  = c("Laredo", "Washington", "Caribou")
  )
)

attr(EastCoast, "responseName") <- "Temperature"

EastCoast

save(EastCoast, file = "data/EastCoast.RData")
