# Print method for two-way tables

Print method for two-way tables

## Usage

``` r
# S3 method for class 'twoway'
print(x, digits = getOption("digits"), border = 2, zapsmall = TRUE, ...)
```

## Arguments

- x:

  a numeric matrix

- digits:

  number of digits to print

- border:

  if 0, the components `"twoway"` object
  (`"overall", "roweff", "coleff", "residuals"`) are printed separately;
  if 1, the row, column and overall effects are joined to the residuals
  in a single table. if 2, row, column, overall and residuals are
  joined, and decorated with horizontal and vertical rules

- zapsmall:

  a logical value; if `TRUE` small residuals are printed as 0.

- ...:

  other arguments passed down

## Author

Michael Friendly, Richard Heiberger

## Examples

``` r
data(taskRT)
task.2way <- twoway(taskRT)
print(task.2way)
#> 
#> Mean decomposition (Dataset: "taskRT"; Response: RT)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         Topic
#> Task       topic1    topic2    topic3    topic4      roweff   
#>          + --------- --------- --------- --------- + ---------
#>   Easy   | -0.055833  0.090833  0.004167 -0.039167 : -0.864167
#>   Medium |  0.119167  0.075833 -0.410833  0.215833 : -0.059167
#>   Hard   | -0.063333 -0.166667  0.406667 -0.176667 :  0.923333
#>          + ......... ......... ......... ......... + .........
#>   coleff | -0.831667 -0.288333  0.358333  0.761667 :  4.181667
#> 
print(task.2way, border=0)
#> 
#> Mean decomposition (Dataset: "taskRT"; Response: RT)
#> 
#> Overall: 4.181667
#> 
#> Row Effects: Task
#>        Easy      Medium        Hard 
#> -0.86416667 -0.05916667  0.92333333 
#> 
#> Column Effects:
#> 
#> Column Effects: Topic
#>     topic1     topic2     topic3     topic4 
#> -0.8316667 -0.2883333  0.3583333  0.7616667 
#> 
#> Residuals:
#>         Topic
#> Task        topic1    topic2     topic3    topic4
#>   Easy   -0.055833  0.090833  0.0041667 -0.039167
#>   Medium  0.119167  0.075833 -0.4108333  0.215833
#>   Hard   -0.063333 -0.166667  0.4066667 -0.176667
#> attr(,"responseName")
#> [1] "RT"
#> 

data(sentRT)
sent.2way <- twoway(sentRT)
print(sent.2way)
#> 
#> Mean decomposition (Dataset: "sentRT"; Response: Value)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         Sent
#> Subj       sent1    sent2    sent3      roweff  
#>          + -------- -------- -------- + --------
#>   subj1  |  0.56667  0.40000 -0.96667 : -3.10000
#>   subj2  |  0.26667  0.00000 -0.26667 : -0.10000
#>   subj3  | -0.83333 -0.40000  1.23333 :  3.20000
#>          + ........ ........ ........ + ........
#>   coleff | -0.73333 -0.36667  1.10000 :  4.96667
#> 
print(sent.2way, border=1)
#> 
#> Mean decomposition (Dataset: "sentRT"; Response: Value)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         Sent
#> Subj        sent1    sent2    sent3  roweff
#>   subj1   0.56667  0.40000 -0.96667 -3.1000
#>   subj2   0.26667  0.00000 -0.26667 -0.1000
#>   subj3  -0.83333 -0.40000  1.23333  3.2000
#>   coleff -0.73333 -0.36667  1.10000  4.9667
#> 
```
