# Mean monthly temperatures in Arizona

This is the data set used by Tukey (1977) for the initial examples of
twoway tables

## Format

a matrix of 7 rows (Month) and 3 columns (City) where the value is mean
monthly temperature in degrees F. The matrix has a `responseName`
attribute, `"Temperature"`

## References

Tukey, J. W. (1977). *Exploratory Data Analysis*, Reading MA:
Addison-Wesley. Exhibit 1 of chapter 10, p. 333

## Examples

``` r
data(Arizona)
(AR.2way <-twoway(Arizona, method="median"))
#> 
#> Median polish decomposition (Dataset: "Arizona"; Response: Temperature)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         City
#> Month      Flagstaff Phoenix Yuma    roweff
#>          + -----     -----   ----- + ----- 
#>   Jul    |   0.0       0.2    -0.9 :  19.1 
#>   Aug    |   0.0       0.2     0.0 :  17.3 
#>   Sep    |  -1.0       0.0     0.0 :  11.9 
#>   Oct    |   0.0       0.0     0.0 :   0.0 
#>   Nov    |   1.9      -0.2     0.0 : -12.2 
#>   Dec    |   1.0       0.0    -0.6 : -18.7 
#>   Jan    |   0.3       0.0     0.0 : -21.1 
#>          + .....     .....   ..... + ..... 
#>   coleff | -24.7       0.0     5.6 :  70.8 
#> 

plot(AR.2way)
```
