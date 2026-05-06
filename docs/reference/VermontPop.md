# Vermont country populations from the US Census, 1900-1990

Vermont country populations from the US Census, 1900-1990

## Usage

``` r
VermontPop
```

## Format

An object of class `data.frame` with 14 rows and 10 columns.

## References

Morgenthaler, Stephan, and John W. Tukey. “Multipolishing and Two-Way
Plots.” Metrika 53.3 (2001): 245–267.

## Examples

``` r
options(digits=4)
VP <- twoway(VermontPop,
             method="median",
             responseName = "log Population")
#> Error: object 'VermontPop' not found
VP
#> Error: object 'VP' not found
plot(VP)
#> Error: object 'VP' not found
```
