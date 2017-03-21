snakecase
================

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/Tazinho/snakecase?branch=master&svg=true)](https://ci.appveyor.com/project/Tazinho/snakecase) [![Travis-CI Build Status](https://travis-ci.org/Tazinho/snakecase.svg?branch=master)](https://travis-ci.org/Tazinho/snakecase) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/snakecase)](https://cran.r-project.org/package=snakecase) [![Coverage Status](https://img.shields.io/codecov/c/github/Tazinho/snakecase/master.svg)](https://codecov.io/github/Tazinho/snakecase?branch=master)

A small package with functions to convert column names of data.frames (or strings in general) to different cases like snake\_case, smallCamel- and BigCamelCase among others.

Install
-------

``` r
# install.packages("devtools")
devtools::install_github("Tazinho/snakecase", ref = "devversion-01", force = TRUE)
```

Usage
-----

``` r
library(snakecase)

strings <- c("smallCamelCase", "BigCamelCase", "SCREAMING_SNAKE_CASE",
             "RRRProjectRRProject", "große Männer_1.2_3-4/5", NA)

# conversion
to_snake_case(strings)
## [1] "small_camel_case"       "big_camel_case"        
## [3] "screaming_snake_case"   "rrr_project_rr_project"
## [5] "große_männer_1.2_3-4/5" NA

to_small_camel_case(strings)
## [1] "smallCamelCase"      "bigCamelCase"        "screamingSnakeCase" 
## [4] "rrrProjectRrProject" "großeMänner1.23-4/5" NA

to_big_camel_case(strings)
## [1] "SmallCamelCase"      "BigCamelCase"        "ScreamingSnakeCase" 
## [4] "RrrProjectRrProject" "GroßeMänner1.23-4/5" NA

to_screaming_snake_case(strings)
## [1] "SMALL_CAMEL_CASE"        "BIG_CAMEL_CASE"         
## [3] "SCREAMING_SNAKE_CASE"    "RRR_PROJECT_RR_PROJECT" 
## [5] "GROSSE_MÄNNER_1.2_3-4/5" NA

to_any_case(strings,
            case = "big_camel", 
            preprocess = "\\.|-|/", 
            replace_special_characters = TRUE)
## [1] "Small_Camel_Case"         "Big_Camel_Case"          
## [3] "Screaming_Snake_Case"     "Rrr_Project_Rr_Project"  
## [5] "Grosse_Maenner_1_2_3_4_5" NA

to_any_case(strings,
            case = "screaming_snake",
            preprocess = "\\.|-|/",
            postprocess = "/",
            prefix = "USER/",
            postfix = ".exe",
            replace_special_characters = TRUE)
## [1] "USER/SMALL/CAMEL/CASE.exe"         "USER/BIG/CAMEL/CASE.exe"          
## [3] "USER/SCREAMING/SNAKE/CASE.exe"     "USER/RRR/PROJECT/RR/PROJECT.exe"  
## [5] "USER/GROSSE/MAENNER/1/2/3/4/5.exe" NA

# test if your names are a valid case (consistent with this package)
# for example smallCamelCase
strings == to_small_camel_case(strings)
## [1]  TRUE FALSE FALSE FALSE FALSE    NA

# compare input and output
library(dplyr)

tibble(inp = strings, outp = to_small_camel_case(strings)) %>% 
  mutate(compare = inp == outp)
## # A tibble: 6 × 3
##                      inp                outp compare
##                    <chr>               <chr>   <lgl>
## 1         smallCamelCase      smallCamelCase    TRUE
## 2           BigCamelCase        bigCamelCase   FALSE
## 3   SCREAMING_SNAKE_CASE  screamingSnakeCase   FALSE
## 4    RRRProjectRRProject rrrProjectRrProject   FALSE
## 5 große Männer_1.2_3-4/5 großeMänner1.23-4/5   FALSE
## 6                   <NA>                <NA>      NA
```

Design Philosophy
-----------------

Practical influences
====================

Conversion to a specific target case is not always obvious or unique. In general a clean conversion can only be guaranted, when the input-string is meaningful.

Take for example a situation where you have IDs for some customers. Instead of calling the column "CustomerID" you abbreviate it to "CID". Without further knowledge about the meaning of CID it will be impossible to know that it should be converted to "c\_id", when using `to_snake_case()`. Instead it will be converted to:

``` r
to_snake_case("CID")
## [1] "cid"
```

We could have also converted to "c\_i\_d" and if we don't know the meaning of "CID", we can't decide which one is the better solution. However it is easy to exclude specific approaches by counterexamples. So in practice it might be nicer to convert "SCREAMING\_SNAKE\_CASE" to "screaming\_snake\_case" instead of "s\_c\_r\_e\_a\_m\_i\_n\_g\_s\_n\_a\_k\_e\_c\_a\_s\_e", which means that also "cid" is preferable to "c\_i\_d".

Since the computer can't know, that we want "c\_id" by himself. It is easiest, if we provide him with the right information (here in form of a valid PascalCase syntax):

``` r
to_snake_case("CId")
## [1] "c_id"
```

In this way it is guaranteed to get the correct conversion and the only chance of an error lies in an accidentally wrong provided input string or a bug in the converter function `to_snake_case()`.

Consistent behaviour
--------------------

However there are two advantages for the first solution.

1.  Often it seams more practical to use the first solution. Cases like "SCREAMING\_SNAKE\_CASE" seem to be more
2.  In this and many other examples you can conclude from a specific logic (which we will introduce next), that

Below you can see the current bahaviour. Those examples that behave as intended (X) and are also tested (`*Td*`) will be stable in the future. Others might be considered to be changed.

Three rules of consistency
--------------------------

In general it might be desirable to have at least sth. like "pairwise inversity" of the three `to_xxx` functions on the space of `to_xxx(string)`. So it might be a good criterion if the following equation holds for any input string:

1.  `to_A(to_B(to_A(string))) = to_A(string)`, (note that this might be equivalent to `to_A(to_B(string))) = to_A(string)`)

where `to_A` and to `to_B` can be `to_snake_case`, `to_small_camel_case` and `to_big_camel_case`.

Note that equality in this equation is only one criterion and it still doesn't imply a unique solution on how to translate an initial string argument to snake or camel case. (Note that also `to_xxx(string) = to_xxx(string)` seems desirable). However, for the following testcases, also these two equations are tested.

Tests
=====

|   nr| examples          | snake\_case          | smallCamelCase | BigCamelCase   | As intended?       |
|----:|:------------------|:---------------------|:---------------|:---------------|:-------------------|
|    1| NA                | NA                   | NA             | NA             | \*Td\*, X          |
|    2| snake\_case       | snake\_case          | snakeCase      | SnakeCase      | \*Td\*, X          |
|    3| snakeCase         | snake\_case          | snakeCase      | SnakeCase      | \*Td\*, X          |
|    4| SnakeCase         | snake\_case          | snakeCase      | SnakeCase      | \*Td\*, X          |
|    5| \_                |                      |                |                |                    |
|    6| snake\_Case       | snake\_case          | snakeCase      | SnakeCase      | \*Td\*, X          |
|    7| \_                |                      |                |                |                    |
|    8| SNake             | s\_nake              | sNake          | SNake          | \*Td\*, ?          |
|    9| Snake             | snake                | snake          | Snake          | \*Td\*, X          |
|   10| s\_nake           | s\_nake              | sNake          | SNake          | \*Td\*, X          |
|   11| sn\_ake           | sn\_ake              | snAke          | SnAke          | \*Td\*, X          |
|   12| \_                |                      |                |                |                    |
|   13| SNaKE             | s\_na\_ke            | sNaKe          | SNaKe          | \*Td\*, ?          |
|   14| SNaKEr            | s\_na\_k\_er         | sNaKEr         | SNaKEr         | \*Td\*, ?          |
|   15| s\_na\_k\_er      | s\_na\_k\_er         | sNaKEr         | SNaKEr         | \*Td\*, X          |
|   16| \_                |                      |                |                |                    |
|   17| SNAKE SNAKE CASE  | snake\_snake\_case   | snakeSnakeCase | SnakeSnakeCase | X \*Td\*           |
|   18| \_                |                      |                |                |                    |
|   19| snakeSnakECase    | snake\_snak\_e\_case | snakeSnakECase | SnakeSnakECase | , \*Td\*           |
|   20| SNAKE snakE\_case | snake\_snak\_e\_case | snakeSnakECase | SnakeSnakECase | \_ ?               |
|   21| \_                |                      |                |                |                    |
|   22| bangBooMBang      | bang\_boo\_m\_bang   | bangBooMBang   | BangBooMBang   | \_ X               |
|   23| upPER             | up\_per              | upPer          | UpPer          | \_ X               |
|   24| CId               | c\_id                | cId            | CId            | \_ ? (maybe c\_id) |
|   25| \_                |                      |                |                | \_ ?               |
|   26| \_\_\_            |                      |                |                | \_ ?               |
|   27| .                 | .                    | .              | .              | \_ ?               |
|   28| ...               | ...                  | ...            | ...            | \_ ?               |
|   29| Sepal.Width       | sepal\_.\_width      | sepal.Width    | Sepal.Width    | \_ X               |
|   30| Var 1             | var\_1               | var1           | Var1           | \_ ? (maybe var1)  |
|   31| Var-2             | var\_-2              | var-2          | Var-2          | \_ ?               |
|   32| Var.3             | var\_.3              | var.3          | Var.3          | \_ ? (maybe var3)  |
|   33| Var4              | var\_4               | var4           | Var4           | \_ X               |
|   34| SnakeCase         | snake\_case          | snakeCase      | SnakeCase      |                    |
|   35| Snake-Case        | snake\_-\_case       | snake-Case     | Snake-Case     |                    |
|   36| Snake Case        | snake\_case          | snakeCase      | SnakeCase      |                    |
|   37| Snake - Case      | snake\_-\_case       | snake-Case     | Snake-Case     |                    |
