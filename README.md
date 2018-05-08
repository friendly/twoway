
<!-- README.md is generated from README.Rmd. Please edit that file -->
twoway
======

The `twoway` package provides analysis and graphical methods for two-way tables with one observation per cell, most typically used in an Analysis of Variance (ANOVA) context. The methods follow Tukey (1949), "One Degree of Freedom for Non-additivity" and Tukey (1972), *Exploratory Data Analysis*, but the graphical ideas are more interesting and general:

-   how to display an **assumed** additive relation between two factors graphically, and visualize departures from an additive fit.
-   how to assess visually whether a power transformation of the response might be more nearly additive in the factors.

This R implementation is based on my SAS macro, [twoway.sas](http://www.datavis.ca/sasmac/twoway.html). It is still at an early stage of development.

Installation
------------

This package has not yet been submitted to CRAN. You can install `twoway` from github with:

``` r
# install.packages("devtools")
devtools::install_github("friendly/twoway")
```

Example
-------

A trivial example shows the analysis of a 3 x 3 table, containing mean reaction times for three subjects presented with three types of sentences and asked to judge whether the sentence was TRUE or FALSE. The questions are:

-   How does reaction time vary with subject and sentence type?
-   Can the results be accounted for by an additive model, with an effect for subject and for sentence type?

``` r
library(twoway)
data("sentRT")
sentRT
#>       sent1 sent2 sent3
#> subj1   1.7   1.9   2.0
#> subj2   4.4   4.5   5.7
#> subj3   6.6   7.4  10.5
```

The `twoway()` function gives the basic analysis: a decomposition of the two-way table, giving the:

-   grand mean ($\\mu = \\bar{x}\_{..}$),
-   row effects ($\\alpha\_i = \\bar{x}\_{i.}-\\mu$),
-   column effects ($\\beta\_j = \\bar{x}\_{.j}-\\mu$), and
-   residuals (*x*<sub>*i**j*</sub> − *μ* − *α*<sub>*i*</sub> − *β*<sub>*j*</sub>)

``` r
twoway(sentRT)
#> 
#> Mean decomposition (Dataset: "sentRT")
#> Residuals bordered by row effects, column effects, and overall
#> 
#>           sent1    sent2    sent3  roweff
#> subj1   0.56667  0.40000 -0.96667 -3.1000
#> subj2   0.26667  0.00000 -0.26667 -0.1000
#> subj3  -0.83333 -0.40000  1.23333  3.2000
#> coleff -0.73333 -0.36667  1.10000  4.9667
```

`twoway()` also allows for a robust fitting by row and column medians, using Tukey's idea of median polish, as implemented in `stats::medpolish()`. This uses `method="median" in the call to`twoway()\`.

The plot method for `twoway` objects currently provides two types of plots:

-   a plot of fitted values under the additive models and residuals (the default, `which="fit"`)
-   a diagnostic plot of interaction residuals vs. comparison values under additivity (`which="diagnose"`). If the points in this plot are reasonably linear and have a non-zero slope, *b*, a suggested power transformation of the response to *x*<sup>1 − *b*</sup> will often remove non-additivity.

``` r
plot(twoway(sentRT))
```

![](README-ex1-plot-1.png)
