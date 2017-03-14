snakecase
================

[![Travis-CI Build Status](https://travis-ci.org/Tazinho/snakecase.svg?branch=master)](https://travis-ci.org/Tazinho/snakecase)

A small package with functions to convert column names of data.frames (or strings in general) to snake\_case, smallCamel- and BigCamelCase.

Install
-------

``` r
# install.packages("devtools")
devtools::install_github("Tazinho/snakecase", ref = "devversion-01")
```

Usage
-----

``` r
library(snakecase)

strings <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "BIGGY BIGGY BIGGY", NA)

to_snake_case(strings)
## [1] "small_camel_case"  "big_camel_case"    "mixed_case"       
## [4] "biggy_biggy_biggy" NA

to_small_camel_case(strings)
## [1] "smallCamelCase"  "bigCamelCase"    "mixedCase"       "biggyBiggyBiggy"
## [5] NA

to_big_camel_case(strings)
## [1] "SmallCamelCase"  "BigCamelCase"    "MixedCase"       "BiggyBiggyBiggy"
## [5] NA
```

Current behaviour (this part is work in progress)
-------------------------------------------------

Conversion to camel case is not always obvious. Below you can see the current bahaviour. Those examples that behave as intended (X) and are also tested (`*Td*`) will be stable in the future. Others might be considered to be changed.

In general it might be desirable to have at least sth. like "pairwise inversity" of the three `to_xxx` functions on the space of `to_xxx(string)`. So it might be a good criterion if the following equation holds for any input string:

1.  `to_A(to_B(to_A(string))) = to_A(string)`, (note that this might be equivalent to `to_A(to_B(string))) = to_A(string)`)

where `to_A` and to `to_B` can be `to_snake_case`, `to_small_camel_case` and `to_big_camel_case`.

However, note equality in this equation is only one criterion and it still doesn't imply a unique solution on how to translate an initial string argument to snake or camel case. (Note that also `to_xxx(string) = to_xxx(string)` seems desirable).

|   nr| examples          | snake\_case          | smallCamelCase | BigCamelCase   | As intended?                                                                                                                          |
|----:|:------------------|:---------------------|:---------------|:---------------|:--------------------------------------------------------------------------------------------------------------------------------------|
|    1| NA                | NA                   | NA             | NA             | X, \*Td\*                                                                                                                             |
|    2| snake\_case       | snake\_case          | snakeCase      | SnakeCase      | X, \*Td\*                                                                                                                             |
|    3| snakeCase         | snake\_case          | snakeCase      | SnakeCase      | X, \*Td\*                                                                                                                             |
|    4| SnakeCase         | snake\_case          | snakeCase      | SnakeCase      | X, \*Td\*                                                                                                                             |
|    5| \_                |                      |                |                |                                                                                                                                       |
|    6| snake\_Case       | snake\_case          | snakeCase      | SnakeCase      | X, \*Td\*                                                                                                                             |
|    7| \_                |                      |                |                |                                                                                                                                       |
|    8| SNake             | s\_nake              | sNake          | SNake          | ? would be ok, but maybe sn\_ake or s\_nake...-&gt; must be s\_nake, because of 10                                                    |
|    9| Snake             | snake                | snake          | Snake          | X, \*Td\*                                                                                                                             |
|   10| s\_nake           | s\_nake              | sNake          | SNake          | X, \*Td\* this one is correct, but it implies that 8 has to be translated to s\_nake (otherwise the equation above does not hold)     |
|   11| sn\_ake           | sn\_ake              | snAke          | SnAke          | X, \*Td\*                                                                                                                             |
|   12| \_                |                      |                |                |                                                                                                                                       |
|   13| SNaKE             | s\_na\_ke            | sNaKe          | SNaKe          | ? the equation holds, but...hm.., better s\_na\_ke (would be consistent with 8 and 10 and still allow for capital letter stuff below) |
|   14| SNaKEr            | s\_na\_k\_er         | sNaKEr         | SNaKEr         | ? the equation holds, but better s\_na\_k\_er, to be consistent with changes (8,10,13)                                                |
|   15| s\_na\_k\_er      | s\_na\_k\_er         | sNaKEr         | SNaKEr         | X, \*Td\* (the equation will also hold for this one, with a change to 14)                                                             |
|   16| \_                |                      |                |                |                                                                                                                                       |
|   17| SNAKE SNAKE CASE  | snake\_snake\_case   | snakeSnakeCase | SnakeSnakeCase | X \*Td\*                                                                                                                              |
|   18| \_                |                      |                |                |                                                                                                                                       |
|   19| snakeSnakECase    | snake\_snak\_e\_case | snakeSnakECase | SnakeSnakECase | ? should be snake\_snak\_e\_case                                                                                                      |
|   20| SNAKE snakE\_case | snake\_snak\_e\_case | snakeSnakECase | SnakeSnakECase | \_ ?                                                                                                                                  |
|   21| \_                |                      |                |                |                                                                                                                                       |
|   22| bangBooMBang      | bang\_boo\_m\_bang   | bangBooMBang   | BangBooMBang   | \_ X                                                                                                                                  |
|   23| upPER             | up\_per              | upPer          | UpPer          | \_ X                                                                                                                                  |
|   24| CId               | c\_id                | cId            | CId            | \_ ? (maybe c\_id)                                                                                                                    |
|   25| \_                |                      |                |                | \_ ?                                                                                                                                  |
|   26| \_\_\_            |                      |                |                | \_ ?                                                                                                                                  |
|   27| .                 |                      |                |                | \_ ?                                                                                                                                  |
|   28| ...               |                      |                |                | \_ ?                                                                                                                                  |
|   29| Sepal.Width       | sepal\_width         | sepalWidth     | SepalWidth     | \_ X                                                                                                                                  |
|   30| Var 1             | var\_1               | var1           | Var1           | \_ ? (maybe var1)                                                                                                                     |
|   31| Var-2             | var\_-2              | var-2          | Var-2          | \_ ?                                                                                                                                  |
|   32| Var.3             | var\_3               | var3           | Var3           | \_ ? (maybe var3)                                                                                                                     |
|   33| Var4              | var\_4               | var4           | Var4           | \_ X                                                                                                                                  |
|   34| SnakeCase         | snake\_case          | snakeCase      | SnakeCase      |                                                                                                                                       |
|   35| Snake-Case        | snake\_-\_case       | snake-Case     | Snake-Case     |                                                                                                                                       |
|   36| Snake Case        | snake\_case          | snakeCase      | SnakeCase      |                                                                                                                                       |
|   37| Snake - Case      | snake\_-\_case       | snake-Case     | Snake-Case     |                                                                                                                                       |
