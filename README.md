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
snakecase::to_snake_case(c("smallCamelCase", "BigCamelCase", "mixed_Case", "BIGGY BIGGY BIGGY", NA))
```

\[1\] "small\_camel\_case" "big\_camel\_case" "mixed\_case"
\[4\] "biggy\_biggy\_biggy" NA
