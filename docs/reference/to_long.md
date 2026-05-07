# Reshape a data.frame or matrix to a long data.frame

Reshape a data.frame or matrix to a long data.frame

Reshape a data.frame or matrix to a wide data.frame

## Usage

``` r
to_long(
  wide,
  rowname = NULL,
  colname = NULL,
  responseName = deparse(substitute(wide)),
  varNames = c("Row", "Col")
)

to_wide(long, row = 1, col = 2, response = 3)
```

## Arguments

- wide:

  A data.frame or matrix in wide form

- rowname:

  Name for the row variable

- colname:

  Name for the column variable

- responseName:

  Name for the response variable. If `wide` is a matrix with an
  attribute that begins with `"response"`, that value is taken as the
  `responseName`. Otherwise, the name of the `wide` object is used.

- varNames:

  Default names for the row and column variables if not passed as
  `rowname` or `colname`

- long:

  A data.frame in long form

- row:

  Column index or quoted name of the row variable

- col:

  Column index or quoted name of the column variable

- response:

  Column index or quoted name of the response variable

## Value

A data.frame in long format

## Author

Michael Friendly and Richard M. Heiberger

## Examples

``` r
Arizona.long <- to_long(Arizona, varNames=c("Month", "City"))
Arizona.long
#>    Month      City Temperature
#> 1    Jul Flagstaff        65.2
#> 2    Aug Flagstaff        63.4
#> 3    Sep Flagstaff        57.0
#> 4    Oct Flagstaff        46.1
#> 5    Nov Flagstaff        35.8
#> 6    Dec Flagstaff        28.4
#> 7    Jan Flagstaff        25.3
#> 8    Jul   Phoenix        90.1
#> 9    Aug   Phoenix        88.3
#> 10   Sep   Phoenix        82.7
#> 11   Oct   Phoenix        70.8
#> 12   Nov   Phoenix        58.4
#> 13   Dec   Phoenix        52.1
#> 14   Jan   Phoenix        49.7
#> 15   Jul      Yuma        94.6
#> 16   Aug      Yuma        93.7
#> 17   Sep      Yuma        88.3
#> 18   Oct      Yuma        76.4
#> 19   Nov      Yuma        64.2
#> 20   Dec      Yuma        57.1
#> 21   Jan      Yuma        55.3

Arizona.long <- to_long(Arizona, varNames=c("Month", "City"))
# back the other way
to_wide(Arizona.long)
#>      City
#> Month Flagstaff Phoenix Yuma
#>   Jul      65.2    90.1 94.6
#>   Aug      63.4    88.3 93.7
#>   Sep      57.0    82.7 88.3
#>   Oct      46.1    70.8 76.4
#>   Nov      35.8    58.4 64.2
#>   Dec      28.4    52.1 57.1
#>   Jan      25.3    49.7 55.3
```
