# twoway 0.6.2

* revised `twoway.default()` to calculate various other quantities and include these in the "twoway" object [RMH]
* revised `plot.twoway()` with separate functions for the "fit" and "diagnose" plots. [RMH]
* added `ladder_power()` to find the nearest ladder of powers value
* enhanced arguments for diagnostic plot: jitter, smooth, pch
* added `residuals.twoway()` and `fitted.twoway()`
* added warning, if `anova.twoway()` is invoked when the model is fit using row/col medians.
* prepare for initial CRAN release.

# twoway 0.6.1

* added `as.twoway()` to give an initial display of a two-way table as a "twoway" object [RMH]
* `print.twoway()` now displays the `names(dimnames(x))` and the `responseName` when available [RMH].

# twoway 0.6.0

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

