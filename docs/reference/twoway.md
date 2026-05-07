# Analysis of a two-way table with one observation per cell

Fits an additive model using either row and column means or Tukey's
median polish procedure

## Usage

``` r
twoway(x, ...)

# Default S3 method
twoway(
  x,
  method = c("mean", "median"),
  ...,
  name = deparse(substitute(x)),
  responseName = attr(x, "response"),
  varNames = names(dimnames(x))
)
```

## Arguments

- x:

  a numeric matrix or data frame.

- ...:

  other arguments passed down

- method:

  one of `"mean"` or `"median"`

- name:

  name for the input dataset

- responseName:

  name for the response variable

- varNames:

  names for the Row and Column variables

## Value

An object of class `c("twoway")` with the following named components:

- overall:

  the fitted constant term.

- roweff:

  the fitted row effects.

- coleff:

  the fitted column effects.

- residuals:

  the residuals.

- name:

  the name of the dataset.

- rownames:

  the names for the rows

- colnames:

  the names for the columns

- method:

  the fitting method

- varNames:

  the names of the row and column variables

- responseName:

  the name of the response variable

- compValue:

  the comparison values, for the diagnostic plot

- slope:

  the slope value, for the diagnostic plot

- power:

  the suggested power transformation, `1-slope`

An object of class `"twoway"`, but supplemented by additional components
used for labeling

## Details

The `rownames(x)` are used as the levels of the row factor and the
`colnames(x`) are the levels of the column factor. For a numeric matrix,
the function uses the `names(dimnames(x))` as the names of these
variables, and, if present, a `responseName` attribute as the name for
the response variable.

## References

Tukey, J. W. (1977). *Exploratory Data Analysis*, Reading MA:
Addison-Wesley.

Friendly, M. (1991). *SAS System for Statistical Graphics* Cary, NC: SAS
Institute

## See also

[`twoway.formula`](https://friendly.github.io/twoway/reference/twoway.formula.md),
[`medpolish`](https://rdrr.io/r/stats/medpolish.html)

[`medianfit`](https://friendly.github.io/twoway/reference/medianfit.md),
[`meanfit`](https://friendly.github.io/twoway/reference/meanfit.md)

## Author

Michael Friendly

## Examples

``` r
data(taskRT)
twoway(taskRT)
#> 
#> Mean decomposition (Dataset: "taskRT"; Response: RT)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         Topic
#> Task       topic1    topic2    topic3    topic4      roweff   
#>          + --------- --------- --------- --------- + ---------
#>   Easy   | -0.055833  0.090833  0.004167 -0.039167 : -0.864167
#>   Medium |  0.119167  0.075833 -0.410833  0.215833 : -0.059167
#>   Hard   | -0.063333 -0.166667  0.406667 -0.176667 :  0.923333
#>          + ......... ......... ......... ......... + .........
#>   coleff | -0.831667 -0.288333  0.358333  0.761667 :  4.181667
#> 
```
