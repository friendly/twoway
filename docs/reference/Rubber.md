# Compressibility of Rubber

The specific volume of natural rubber was measured at four values of
temperature and six values of pressure. Is there any evidence that
volume is not an additive relation with temperature and pressure?

## Usage

``` r
Rubber
```

## Format

a 4 x 6 matrix, where the cell values are the specific volume (in cubic
centimeters per gram) of peroxide-cured rubber. The row and column
variables are:

- Temperature, in degrees Celsius

- Pressure, in kg / cm^2 above atmospheric pressure.

## Source

Wood, L. A. & Martin, G. M. (1964). "Compressibility of natural rubber
at pressures below 500kg/cm^2", Journal of Research of the National
Standards Bureau–A. Physics & Chemistry, \*\*68A\*\*, 259–268.

## References

Emerson, J. D. & Wong, G. Y. (1985). "Resistant Nonadditve Fits for
Two-Way Tables". In Hoaglin, D. C., Mosteller, F., & Tukey, J. W.
(Eds.). Exploring data tables, trends and shapes. John Wiley Sons. Ch.
3, Table 3.1.

## Examples

``` r
data(Rubber)
#> Warning: data set 'Rubber' not found
# scale the response to avoid small decimals
rub <- 10000*Rubber
#> Error: object 'Rubber' not found
rubfit <- twoway(rub, "median")
#> Error: object 'rub' not found
plot(rubfit)
#> Error: object 'rubfit' not found
```
