# Fit a two-way table using median polish

Fit a two-way table using median polish

## Usage

``` r
medianfit(x, trace.iter = FALSE, ...)
```

## Arguments

- x:

  a numeric matrix or data frame

- trace.iter:

  whether to give verbose output of iteration history in median polish.

- ...:

  other arguments passed down

## Value

An object of class `c("twoway", "medpolish")` with the following named
components:

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
