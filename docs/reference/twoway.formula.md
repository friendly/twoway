# Formula method for twoway analysis using a dataset in long format

The formula method reshapes the data set from long to wide format and
calls the default method.

## Usage

``` r
# S3 method for class 'formula'
twoway(formula, data, subset, na.action, ...)
```

## Arguments

- formula:

  A formula of the form `response ~ rowvar + colvar`, where `response`
  is numeric

- data:

  The name of the data set, containing a row vector, column factor and a
  numeric response

- subset:

  An expression to subset the data (unused)

- na.action:

  What to do with NAs? (unused)

- ...:

  other arguments, passed down

## References

the conversion of long to wide in a formula method was suggested on
<https://stackoverflow.com/questions/50469320/how-to-write-a-formula-method-that-converts-long-to-wide>

## Author

Michael Friendly and Richard Heiberger

## Examples

``` r
longRT <- to_long(taskRT)
RT.2way <-twoway(RT ~ Task + Topic, data=longRT)
RT.2way
#> 
#> Mean decomposition (Dataset: "longRT"; Response: RT)
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
anova(RT.2way)
#> Dataset: longRT; method: "mean"
#> 
#> Analysis of Variance Table, assuming additivity
#> 
#>           Df Sum Sq Mean Sq F value    Pr(>F)    
#> row        2 6.4113  3.2057  40.355 0.0003313 ***
#> col        3 4.4500  1.4833  18.673 0.0019073 ** 
#> Residuals  6 0.4766  0.0794                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Analysis of Variance Table, allowing non-additivity
#> 
#>            Df Sum Sq Mean Sq F value   Pr(>F)   
#> row         2 6.4113  3.2057 34.0366 0.001225 **
#> col         3 4.4500  1.4833 15.7497 0.005570 **
#> nonadd      1 0.0057  0.0057  0.0606 0.815402   
#> pure error  5 0.4709  0.0942                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
