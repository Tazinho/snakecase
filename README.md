snakecase
================

[![Build Status](https://travis-ci.org/Tazinho/snakecase.svg?branch=master)](https://travis-ci.org/Tazinho/snakecase)

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
