# Convert a twoway object to a data frame This function converts a `"twoway"` object to a `data.frame`

The rows and columns of the data table are strung out in standard R
order in a vector, joined with row and column labels. Additional columns
are added, representing the calculated values used in the two-way
display.

## Usage

``` r
# S3 method for class 'twoway'
as.data.frame(x, ...)
```

## Arguments

- x:

  a `"twoway"` object

- ...:

  other arguments, presently ignored

## Value

a data.frame with \\r \times c\\ rows corresponding to the input data
table, and the following columns

- row:

  row labels

- col:

  column labels

- data:

  the data value in the cell

- fit:

  the fitted value,

- roweff:

  the row effect

- coleff:

  the column effect

- nonadd:

  the 1 df for non-additivity value

## Examples

``` r
data(sentRT)
sent.2way <- twoway(sentRT)
as.data.frame(sent.2way)
#>     row   col data      fit      dif   residual roweff     coleff      nonadd
#> 1 subj1 sent1  1.7 1.133333 7.333333  0.5666667   -3.1 -0.7333333  0.45771812
#> 2 subj2 sent1  4.4 4.133333 4.333333  0.2666667   -0.1 -0.7333333  0.01476510
#> 3 subj3 sent1  6.6 7.433333 1.033333 -0.8333333    3.2 -0.7333333 -0.47248322
#> 4 subj1 sent2  1.9 1.500000 7.700000  0.4000000   -3.1 -0.3666667  0.22885906
#> 5 subj2 sent2  4.5 4.500000 4.700000  0.0000000   -0.1 -0.3666667  0.00738255
#> 6 subj3 sent2  7.4 7.800000 1.400000 -0.4000000    3.2 -0.3666667 -0.23624161
#> 7 subj1 sent3  2.0 2.966667 9.166667 -0.9666667   -3.1  1.1000000 -0.68657718
#> 8 subj2 sent3  5.7 5.966667 6.166667 -0.2666667   -0.1  1.1000000 -0.02214765
#> 9 subj3 sent3 10.5 9.266667 2.866667  1.2333333    3.2  1.1000000  0.70872483
```
