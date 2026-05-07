# Find the nearest ladder-of-powers representation of a power transformation

The input power value is rounded to the nearest integer or fractional
powers, \\\pm 1/3, 1/2\\. The function is presently designed just for
display purposes.

## Usage

``` r
ladder_power(p)
```

## Arguments

- p:

  A numeric power, for use as a transformation of a response, y, of the
  form \\y^p\\, where `p=0` is interpreted to mean \\log(y)\\

## Value

a named list of two elements: `power`, the ladder-of-power value, and
`name`, the name for the transformation

## Details

In use, the transformation via the ladder of powers usually attaches a
minus sign to the transformation when the `power < 0`, so that the order
of the response values are preserved under the transformation. Thus, a
result of `power = -0.5` is interpreted to mean \\-1 / \sqrt{y}\\.

## References

Tukey, J. W. (1977). *Exploratory Data Analysis*, Reading MA:
Addison-Wesley.

## Examples

``` r
ladder_power(0.6)
#> $power
#> [1] 0.5
#> 
#> $name
#> [1] "square root"
#> 
ladder_power(-0.6)
#> $power
#> [1] -0.5
#> 
#> $name
#> [1] "reciprocal root"
#> 
```
