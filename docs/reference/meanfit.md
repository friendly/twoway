# Fit a two-way table using row and column means

Fit a two-way table using row and column means

## Usage

``` r
meanfit(x, ..., na.rm = FALSE)
```

## Arguments

- x:

  a numeric matrix or data frame

- ...:

  other arguments passed down

- na.rm:

  logical. Should missing values be removed?

## Value

An object of class `c("twoway")` with the following named components:

- overall:

  the fitted constant term.

- roweff:

  the fitted row effects.

- coleff:

  the fitted column effects.

- residuals:

  the residuals.

- name:

  the name of the dataset.

- rownames:

  the names for the rows

- colnames:

  the names for the columns

- method:

  "median"
