# Extract residuals from a twoway object

Extract residuals from a twoway object

Extract fitted values from a twoway object

## Usage

``` r
# S3 method for class 'twoway'
residuals(object, nonadd = FALSE, ...)

# S3 method for class 'twoway'
fitted(object, nonadd = FALSE, ...)
```

## Arguments

- object:

  A `class="twoway"` object

- nonadd:

  If `TRUE`, the 1 degree of freedom term for non-additivity is
  subtracted from the additive residuals

- ...:

  other arguments (unused)

## Value

A numeric matrix of residuals corresponding to the data supplied to
`twoway`

A numeric matrix of fitted values corresponding to the data supplied to
`twoway`

## Examples

``` r
data(taskRT)
task.2way <- twoway(taskRT)
residuals(task.2way)
#>         Topic
#> Task          topic1      topic2       topic3      topic4
#>   Easy   -0.05583333  0.09083333  0.004166667 -0.03916667
#>   Medium  0.11916667  0.07583333 -0.410833333  0.21583333
#>   Hard   -0.06333333 -0.16666667  0.406666667 -0.17666667
#> attr(,"responseName")
#> [1] "RT"
residuals(task.2way, nonadd=TRUE)
#>         Topic
#> Task          topic1      topic2      topic3       topic4
#>   Easy   -0.09103355  0.07862965  0.01933309 -0.006929193
#>   Medium  0.11675662  0.07499779 -0.40979494  0.218040528
#>   Hard   -0.02572307 -0.15362744  0.39046184 -0.211111335
#> attr(,"responseName")
#> [1] "RT"

sum(residuals(task.2way)^2)               #  SSE for additive model
#> [1] 0.4766167
sum(residuals(task.2way, nonadd=TRUE)^2)  # SSPE, non-additive model
#> [1] 0.4709134
data(taskRT)
task.2way <- twoway(taskRT)
fitted(task.2way)
#>          topic1   topic2   topic3   topic4
#> Easy   4.900365 4.430835 3.872007 3.523460
#> Medium 4.230874 4.198726 4.160465 4.136601
#> Hard   3.413761 3.915439 4.512528 4.884939
fitted(task.2way, nonadd=TRUE)
#>          topic1   topic2   topic3   topic4
#> Easy   4.935565 4.443038 3.856841 3.491222
#> Medium 4.233284 4.199562 4.159427 4.134394
#> Hard   3.376151 3.902400 4.528733 4.919384
```
