# ANOVA summary for a two-way table, including Tukey Additivity Test

Test for a 1-df interaction in two-way ANOVA table by the Tukey test.

## Usage

``` r
# S3 method for class 'twoway'
anova(object, ...)
```

## Arguments

- object:

  a `class("twoway")` object

- ...:

  other arguments passed down, but not used here

## Details

At present, this function simply gives the results of the ANOVAs for the
additive model, the model including the 1 df term for non-additivity,
and an [`anova()`](https://rdrr.io/r/stats/anova.html) comparison of the
two. The analysis is based on row and column means.

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
#> row        2 59.580 29.7900 30.2949 0.003835 **
#> col        2  5.647  2.8233  2.8712 0.168574   
#> Residuals  4  3.933  0.9833                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Analysis of Variance Table, allowing non-additivity
#> 
#>            Df Sum Sq Mean Sq F value    Pr(>F)    
#> row         2 59.580 29.7900 513.449 0.0001572 ***
#> col         2  5.647  2.8233  48.662 0.0051710 ** 
#> nonadd      1  3.759  3.7593  64.793 0.0040046 ** 
#> pure error  3  0.174  0.0580                      
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
