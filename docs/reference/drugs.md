# Scores for 5 subjects after being given each of 4 drugs

The original source is Winer (1971), p. 268. This was used as an example
in Friendly (1991).

## References

Friendly, M. (1991). *SAS System for Statistical Graphics* Cary, NC: SAS
Institute, Output 7.28

## Examples

``` r
data(drugs)
tw <- twoway(drugs) |>
  print()
#> 
#> Mean decomposition (Dataset: "drugs"; Response: Value)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>          drug1 drug2 drug3 drug4   roweff
#>        + ----  ----  ----  ----  + ----  
#> subj1  | -4.7  -0.7   2.5   2.9  :  9.1  
#> subj2  | -1.7   0.3   1.5  -0.1  :  2.1  
#> subj3  | -1.2   2.8   0.0  -1.6  : -0.4  
#> subj4  |  4.3  -3.7  -0.5  -0.1  : -1.9  
#> subj5  |  3.3   1.3  -3.5  -1.1  : -8.9  
#>        + ....  ....  ....  ....  + ....  
#> coleff | -9.3   0.7   1.5   7.1  : 24.9  
#> 

plot(tw)
```
