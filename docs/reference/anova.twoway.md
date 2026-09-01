# ANOVA summary for a two-way table, including Tukey Additivity Test

Test for a 1-df interaction in two-way ANOVA table by the Tukey test.

## Usage

``` r
# S3 method for class 'twoway'
anova(object, test = c("both", "add", "nonadd"), ...)

# S3 method for class 'anova.twoway'
print(x, ...)
```

## Arguments

- object:

  a `class("twoway")` object

- test:

  one of `"both"`, `"add"`, `"nonadd"`: which model(s) to fit and
  report. `"add"` fits the additive model alone; `"nonadd"` fits the
  model that adds the 1 df term for non-additivity (the Tukey test,
  shown as the `nonadd` row); `"both"` (default) fits and reports both.

- ...:

  other arguments passed down, but not used here

- x:

  an object of class `"anova.twoway"`, from `anova.twoway`

## Value

An object of class `"anova.twoway"`: a named list of the fitted model(s)
(`additive` and/or `nonadditive`, each an `"aov"` object, depending on
`test`), with the dataset name and fitting method attached as attributes
for the print method to report.

## Details

Fits the additive model, the model adding the 1 df term for
non-additivity, or both (the default), depending on `test`. The analysis
is based on row and column means.

The non-additive model's ANOVA table already includes the Tukey test as
its `nonadd` row. To instead see it as a direct comparison of the two
fitted models, call [`anova()`](https://rdrr.io/r/stats/anova.html) on
the two components of the result, e.g.
`anova(result$additive, result$nonadditive)` – this reproduces the same
F and p-value as the `nonadd` row.

## References

Tukey, J. W. (1949). One Degree of Freedom for Non-Additivity.
*Biometrics*, 5(3), 232-242.
[doi:10.2307/3001938](https://doi.org/10.2307/3001938)

## Author

Michael Friendly

## Examples

``` r
data(sentRT)
sent.2way <- twoway(sentRT)
anova(sent.2way)
#> Dataset: sentRT; method: "mean"
#> 
#> Analysis of Variance Table, assuming additivity
#> 
#>           Df Sum Sq Mean Sq F value   Pr(>F)   
#> Subj       2 59.580 29.7900 30.2949 0.003835 **
#> Sent       2  5.647  2.8233  2.8712 0.168574   
#> Residuals  4  3.933  0.9833                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Analysis of Variance Table, allowing non-additivity
#> 
#>            Df Sum Sq Mean Sq F value    Pr(>F)    
#> Subj        2 59.580 29.7900 513.449 0.0001572 ***
#> Sent        2  5.647  2.8233  48.662 0.0051710 ** 
#> nonadd      1  3.759  3.7593  64.793 0.0040046 ** 
#> pure error  3  0.174  0.0580                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

data(EastCoast)
EC.2way <- twoway(EastCoast)
anova(EC.2way)
#> Dataset: EastCoast; method: "mean"
#> 
#> Analysis of Variance Table, assuming additivity
#> 
#>           Df Sum Sq Mean Sq F value    Pr(>F)    
#> Month      6 5222.4  870.40  27.655 2.339e-06 ***
#> City       2 5315.5 2657.76  84.443 8.524e-08 ***
#> Residuals 12  377.7   31.47                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Analysis of Variance Table, allowing non-additivity
#> 
#>            Df Sum Sq Mean Sq F value    Pr(>F)    
#> Month       6 5222.4  870.40  548.70 5.728e-13 ***
#> City        2 5315.5 2657.76 1675.45 2.145e-14 ***
#> nonadd      1  360.2  360.24  227.09 1.085e-08 ***
#> pure error 11   17.4    1.59                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

data(hstart)
hstart.2way <- twoway(hstart)
anova(hstart.2way)
#> Dataset: hstart; method: "mean"
#> 
#> Analysis of Variance Table, assuming additivity
#> 
#>           Df Sum Sq Mean Sq F value    Pr(>F)    
#> year       8 112905 14113.2  50.971 < 2.2e-16 ***
#> month     11  64978  5907.1  21.334 < 2.2e-16 ***
#> Residuals 88  24366   276.9                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Analysis of Variance Table, allowing non-additivity
#> 
#>            Df Sum Sq Mean Sq F value  Pr(>F)    
#> year        8 112905 14113.2 53.5510 < 2e-16 ***
#> month      11  64978  5907.1 22.4139 < 2e-16 ***
#> nonadd      1   1437  1437.2  5.4534 0.02183 *  
#> pure error 87  22929   263.5                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

data(Arizona)
AR.2way <- twoway(Arizona)
anova(AR.2way)
#> Dataset: Arizona; method: "mean"
#> 
#> Analysis of Variance Table, assuming additivity
#> 
#>           Df Sum Sq Mean Sq F value    Pr(>F)    
#> Month      6 5132.2  855.37  2304.9 < 2.2e-16 ***
#> City       2 3525.9 1762.94  4750.4 < 2.2e-16 ***
#> Residuals 12    4.5    0.37                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Analysis of Variance Table, allowing non-additivity
#> 
#>            Df Sum Sq Mean Sq   F value Pr(>F)    
#> Month       6 5132.2  855.37 2904.0166 <2e-16 ***
#> City        2 3525.9 1762.94 5985.2512 <2e-16 ***
#> nonadd      1    1.2    1.21    4.1192 0.0673 .  
#> pure error 11    3.2    0.29                     
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# just the additive-model ANOVA
anova(sent.2way, test = "add")
#> Dataset: sentRT; method: "mean"
#> 
#> Analysis of Variance Table, assuming additivity
#> 
#>           Df Sum Sq Mean Sq F value   Pr(>F)   
#> Subj       2 59.580 29.7900 30.2949 0.003835 **
#> Sent       2  5.647  2.8233  2.8712 0.168574   
#> Residuals  4  3.933  0.9833                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# just the non-additive-model ANOVA -- the Tukey test is its `nonadd` row
result <- anova(sent.2way, test = "nonadd")
result$nonadditive
#> Call:
#>    aov(formula = ref2, data = z)
#> 
#> Terms:
#>                     Subj     Sent   nonadd Residuals
#> Sum of Squares  59.58000  5.64667  3.75928   0.17406
#> Deg. of Freedom        2        2        1         3
#> 
#> Residual standard error: 0.2408721
#> Estimated effects may be unbalanced

# the same Tukey test, as a direct comparison of the two fitted models
both <- anova(sent.2way)
anova(both$additive, both$nonadditive)
#> Analysis of Variance Table
#> 
#> Model 1: data ~ Subj + Sent
#> Model 2: data ~ Subj + Sent + nonadd
#>   Res.Df    RSS Df Sum of Sq      F   Pr(>F)   
#> 1      4 3.9333                                
#> 2      3 0.1741  1    3.7593 64.793 0.004005 **
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
