# Reaction times for T/F judgments

A demonstration 3 x 3 two-way table composed of reaction times for three
subjects making T/F judgments on three types of sentences

## References

Friendly, M. (1991). *SAS System for Statistical Graphics* Cary, NC: SAS
Institute, Table 7.2

## Examples

``` r
data(sentRT)
twoway(sentRT)
#> 
#> Mean decomposition (Dataset: "sentRT"; Response: Value)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>          sent1    sent2    sent3      roweff  
#>        + -------- -------- -------- + --------
#> subj1  |  0.56667  0.40000 -0.96667 : -3.10000
#> subj2  |  0.26667  0.00000 -0.26667 : -0.10000
#> subj3  | -0.83333 -0.40000  1.23333 :  3.20000
#>        + ........ ........ ........ + ........
#> coleff | -0.73333 -0.36667  1.10000 :  4.96667
#> 
```
