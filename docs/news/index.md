# Changelog

## twoway 0.7.0

- revised twoway functions to use the names of variables for row/col
- fixed documentation errors/warnings
- include more graphs in examples
- using \|\> pipes in examples: now depends on R \>= 4.1

## twoway 0.6.4

- added VermontPop data
- added Rubber data

## twoway 0.6.3

CRAN release: 2020-06-26

- revised
  [`plot.twoway()`](https://friendly.github.io/twoway/reference/plot.twoway.md)
  to use and default to na.rm=FALSE
- revised
  [`plot.twoway.fit()`](https://friendly.github.io/twoway/reference/plot.twoway.md)
  to use and default to na.rm=FALSE
- revised
  [`meanfit()`](https://friendly.github.io/twoway/reference/meanfit.md)
  to use and default to na.rm=FALSE
- revised
  [`twoway.default()`](https://friendly.github.io/twoway/reference/twoway.md)
  to pass … (hence na.rm) to meanfit
- added demo/ directory
- added demo/example-na.r to illustrate use of na.rm
- added demo/00Index
- Turn on travis CI

## twoway 0.6.2

CRAN release: 2018-08-24

- revised
  [`twoway.default()`](https://friendly.github.io/twoway/reference/twoway.md)
  to calculate various other quantities and include these in the
  “twoway” object \[RMH\]
- revised
  [`plot.twoway()`](https://friendly.github.io/twoway/reference/plot.twoway.md)
  with separate functions for the “fit” and “diagnose” plots. \[RMH\]
- added
  [`ladder_power()`](https://friendly.github.io/twoway/reference/ladder_power.md)
  to find the nearest ladder of powers value
- enhanced arguments for diagnostic plot: jitter, smooth, pch
- added
  [`residuals.twoway()`](https://friendly.github.io/twoway/reference/residuals.md)
  and
  [`fitted.twoway()`](https://friendly.github.io/twoway/reference/residuals.md)
- added warning, if
  [`anova.twoway()`](https://friendly.github.io/twoway/reference/anova.twoway.md)
  is invoked when the model is fit using row/col medians.
- prepare for initial CRAN release.

## twoway 0.6.1

- added
  [`as.twoway()`](https://friendly.github.io/twoway/reference/as.twoway.md)
  to give an initial display of a two-way table as a “twoway” object
  \[RMH\]
- [`print.twoway()`](https://friendly.github.io/twoway/reference/print.twoway.md)
  now displays the `names(dimnames(x))` and the `responseName` when
  available \[RMH\].

## twoway 0.6.0

- Change some built-in data sets to matrices with proper
  names(dimnames); in matrix form, a `"responseName"` attribute is now
  partially supported in some functions.
- Added
  [`to_long()`](https://friendly.github.io/twoway/reference/to_long.md)
  and
  [`to_wide()`](https://friendly.github.io/twoway/reference/to_long.md)
  to facilitate working either way \[RMH\]
- [`twoway.formula()`](https://friendly.github.io/twoway/reference/twoway.formula.md)
  now uses
  [`to_wide()`](https://friendly.github.io/twoway/reference/to_long.md)
  rather than `tidyr` constructs, resulting in a big speed-up
- [`twoway.default()`](https://friendly.github.io/twoway/reference/twoway.md)
  now calculates the slope for the diagnostic plot, including it in the
  object \[Suggestion: RMH\]
- [`twoway.default()`](https://friendly.github.io/twoway/reference/twoway.md)
  now prefers matrix inputs, allowing better labels for row/col/response
  variables, but not yet implemented throughout the various methods.

## twoway 0.5.0

- Added a
  [`twoway.formula()`](https://friendly.github.io/twoway/reference/twoway.formula.md)
  method

## twoway 0.4.1

- Modified the twoway plot method per suggestions of RMH (better axis
  labels)
- `plot.twoway(..., which="diagnose")` gets an `annotate=` argument
- [`print.twoway()`](https://friendly.github.io/twoway/reference/print.twoway.md)
  gets a `zapsmall=` argument per RMH
- Added `insectCounts` data
- Revised
  [`anova.twoway()`](https://friendly.github.io/twoway/reference/anova.twoway.md)
  to be less redundant

## twoway 0.4.0

- Added an initial
  [`anova.twoway()`](https://friendly.github.io/twoway/reference/anova.twoway.md)
  method
- Update README

## twoway 0.3.0

- Added a `NEWS.md` file to track changes to the package.
- Added a `as.data.frame` method for `twoway` objects. This simpilifies
  graphical displays and other computations.
- [`print.twoway()`](https://friendly.github.io/twoway/reference/print.twoway.md)
  gets a `border=2` option to print the result in a fancy table with
  horizontal and vertical separators \[thx: Richard Heiberger\]
