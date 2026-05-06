# Create an initial twoway object representing the data before fitting

Create an initial twoway object representing the data before fitting

Method for matrix input

## Usage

``` r
as.twoway(x, ...)

# S3 method for class 'matrix'
as.twoway(
  x,
  ...,
  name = deparse(substitute(x)),
  responseName = name,
  varNames = names(dimnames(x))
)
```

## Arguments

- x:

  a numeric matrix or numeric data frame with rownames

- ...:

  other arguments, unused here

- name:

  Name of the data matrix

- responseName:

  Name of the response variable

- varNames:

  Names of the row and column variables

## Value

An object of class `c("twoway")` with all effects(roweff, coleff,
overall) set to zero, and `method="Initial"`

## Author

Richard M. Heiberger

## Examples

``` r
data(taskRT)
as.twoway(taskRT)
#> 
#> Initial data (Dataset: "taskRT"; Response: RT)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         Topic
#> Task       topic1 topic2 topic3 topic4   roweff
#>          + ----   ----   ----   ----   + ----  
#>   Easy   | 2.43   3.12   3.68   4.04   : 0.00  
#>   Medium | 3.41   3.91   4.07   5.10   : 0.00  
#>   Hard   | 4.21   4.65   5.87   5.69   : 0.00  
#>          + ....   ....   ....   ....   + ....  
#>   coleff | 0.00   0.00   0.00   0.00   : 0.00  
#> 
```
