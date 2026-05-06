# Data on reaction times for various tasks and topics

A demonstration 3 x 4 two-way table composed of reaction times for tasks
varying in difficulty, with content on different topics.

## Format

A matrix of 3 rows and 4 columns, where the rows are the task difficulty
levels and the columns are the the topics. The cell values are average
reaction times (in sec.). The matrix has a `responseName` attribute,
`"RT"`

## Examples

``` r
data(taskRT)
twoway(taskRT)
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
twoway(taskRT, method="median")
#> 
#> Median polish decomposition (Dataset: "taskRT"; Response: RT)
#> Residuals bordered by row effects, column effects, and overall
#> 
#>         Topic
#> Task       topic1  topic2  topic3  topic4    roweff 
#>          + ------- ------- ------- ------- + -------
#>   Easy   | -0.0850  0.1050  0.0000  0.0000 : -0.8950
#>   Medium |  0.0000  0.0000 -0.5050  0.1650 :  0.0000
#>   Hard   |  0.0225 -0.0375  0.5175 -0.0225 :  0.7775
#>          + ....... ....... ....... ....... + .......
#>   coleff | -0.8325 -0.3325  0.3325  0.6925 :  4.2425
#> 
```
