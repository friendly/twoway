# twoway 0.5.1

* Change some built-in data sets to matrices with proper names(dimnames); in matrix form, a `"responseName"` attribute is now partially supported in some functions.
* Added `to_long()` and `to_wide()` to facilitate working either way [RMH]
* `twoway.formula()` now uses `to_wide()` rather than `tidyr` constructs, resulting in a big speed-up 
* `twoway.default()` now calculates the slope for the diagnostic plot, including it in the object [Suggestion: RMH]
* `twoway.default()` now prefers matrix inputs, allowing better labels for row/col/response variables, but not yet implemented throughout the various methods.

# twoway 0.5.0

* Added a `twoway.formula()` method

# twoway 0.4.1

* Modified the twoway plot method per suggestions of RMH (better axis labels)
* `plot.twoway(..., which="diagnose")` gets an `annotate=` argument
* `print.twoway()` gets a `zapsmall=` argument per RMH
* Added `insectCounts` data
* Revised `anova.twoway()` to be less redundant

# twoway 0.4.0

* Added an initial `anova.twoway()` method
* Update README

# twoway 0.3.0

* Added a `NEWS.md` file to track changes to the package.
* Added a `as.data.frame` method for `twoway` objects. This similifies graphical displays and other computations.
* `print.twoway()` gets a `border=2` option to print the result in a fancy table with horizontal and vertical separators [thx: Richard Heiberger]

