snakecase
================

A small package with functions to convert column names of data.frames (or strings in general) to snake\_case, smallCamel- and BigCamelCase.

Install
-------

``` r
devtools::install_github("Tazinho/snakecase")
```

Usage
-----

``` r
library(snakecase)

to_snake_case(c("smallCamelCase", "BigCamelCase", "mixed_Case", "BIGGY BIGGY BIGGY", NA))
## [1] "small_camel_case"  "big_camel_case"    "mixed_case"       
## [4] "biggy_biggy_biggy" NA

to_small_camel_case(c("smallCamelCase", "BigCamelCase", "mixed_Case", "BIGGY BIGGY BIGGY", NA))
## [1] "smallCamelCase"  "bigCamelCase"    "mixedCase"       "biggyBiggyBiggy"
## [5] NA

to_big_camel_case(c("smallCamelCase", "BigCamelCase", "mixed_Case", "BIGGY BIGGY BIGGY", NA))
## [1] "SmallCamelCase"  "BigCamelCase"    "MixedCase"       "BiggyBiggyBiggy"
## [5] NA
```
