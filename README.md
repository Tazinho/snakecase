snakecase
================

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/Tazinho/snakecase?branch=master&svg=true)](https://ci.appveyor.com/project/Tazinho/snakecase) [![Travis-CI Build Status](https://travis-ci.org/Tazinho/snakecase.svg?branch=master)](https://travis-ci.org/Tazinho/snakecase) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/snakecase)](https://cran.r-project.org/package=snakecase) [![Coverage Status](https://img.shields.io/codecov/c/github/Tazinho/snakecase/master.svg)](https://codecov.io/github/Tazinho/snakecase?branch=master)

<img src="./logo_snakecase.png" height="200">

<!--A small package with functions to convert column names of data.frames (or strings
in general) to different cases like snake_case, smallCamel- and BigCamelCase among others. Also high level features for more advanced case conversions are provided via `to_any_case()`.-->
The snakecase package contains five specific case converter functions and one more general high level function with additional functionality.

Install
-------

``` r
# install.packages("devtools")
# devtools::install_github("Tazinho/snakecase", ref = "devversion-01", force = TRUE, build_vignettes = TRUE)
devtools::install_github("Tazinho/snakecase")
```

Usage
=====

Specific case converters
------------------------

``` r
library(snakecase)
strings <- c("this Is a Strange_string", "AND THIS ANOTHER_One")

to_parsed_case(strings)
## [1] "this_Is_a_Strange_string" "AND_THIS_ANOTHER_One"

to_snake_case(strings)
## [1] "this_is_a_strange_string" "and_this_another_one"

to_small_camel_case(strings)
## [1] "thisIsAStrangeString" "andThisAnotherOne"

to_big_camel_case(strings)
## [1] "ThisIsAStrangeString" "AndThisAnotherOne"

to_screaming_snake_case(strings)
## [1] "THIS_IS_A_STRANGE_STRING" "AND_THIS_ANOTHER_ONE"
```

Highlevel case converter
------------------------

The function `to_any_case()` can do everything that the others can and also adds some extra high level functionality.

### Default usage

``` r
to_any_case(strings, case = "parsed")
## [1] "this_Is_a_Strange_string" "AND_THIS_ANOTHER_One"

to_any_case(strings, case = "snake")
## [1] "this_is_a_strange_string" "and_this_another_one"

to_any_case(strings, case = "small_camel")
## [1] "thisIsAStrangeString" "andThisAnotherOne"

to_any_case(strings, case = "big_camel")
## [1] "ThisIsAStrangeString" "AndThisAnotherOne"

to_any_case(strings, case = "screaming_snake")
## [1] "THIS_IS_A_STRANGE_STRING" "AND_THIS_ANOTHER_ONE"
```

### Pre -and postprocessing

By default only whitespaces, underscores and some patterns of mixed lower/upper case letter combinations are recognized as word boundaries. You can specify anything as a word boundary which is a valid stringr regular expression:

``` r
strings2 <- c("this - Is_-: a Strange_string", "ÄND THIS ANOTHER_One")

to_snake_case(strings2)
## [1] "this_-_is_-_:_a_strange_string" "änd_this_another_one"

to_any_case(strings2, case = "snake", preprocess = "-|\\:")
## [1] "this_is_a_strange_string" "änd_this_another_one"
```

You can also specify a different separator than `"_"` or `""` via `postprocess`:

``` r
to_any_case(strings2, case = "snake", preprocess = "-|\\:", postprocess = " ")
## [1] "this is a strange string" "änd this another one"

to_any_case(strings2, case = "big_camel", preprocess = "-|\\:", postprocess = "//")
## [1] "This//Is//A//Strange//String" "Änd//This//Another//One"
```

### Pre -and postfix

You can set pre -and suffixes:

``` r
to_any_case(strings2, case = "big_camel", preprocess = "-|\\:", postprocess = "//",
            prefix = "USER://", postfix = ".exe")
## [1] "USER://This//Is//A//Strange//String.exe"
## [2] "USER://Änd//This//Another//One.exe"
```

### Special characters

If you have problems with special characters on your platform, you can replace them via `replace_special_characters = TRUE`:

``` r
strings3 <- c("ßüss üß ä stränge sträng", "unrealistisch aber nützich")

to_any_case(strings3, case = "screaming_snake", replace_special_characters = TRUE)
## [1] "SSUESS_UESS_AE_STRAENGE_STRAENG" "UNREALISTISCH_ABER_NUETZICH"
```

### Protect anything

If you see unwanted underscores around specific pattern, which you don't want to delete via `preprocess`, just use `protect`:

``` r
strings4 <- c("var12", "var1.2", "va.r.1.2")

to_any_case(strings4, case = "snake")
## [1] "var_1_2"        "var_1_._2"      "va_._r_._1_._2"
to_any_case(strings4, case = "snake", protect = "\\d")
## [1] "var12"       "var1.2"      "va_._r_.1.2"
to_any_case(strings4, case = "snake", protect = "\\d|\\.")
## [1] "var12"    "var1.2"   "va.r.1.2"
```

### Vectorisation

`to_any_case()` is vectorised over `string`, `preprocess`, `postprocess`, `prefix`, `postfix` and `protect`.

### More complex stuff

Since `preprocess` and `protect` allow to use regular expressions, `to_any_case()` becomes very flexible and can achieve complex operations. Lets assume, that you want to translate a string, which contains dots and decimal numbers, into snakecase. You want that the dots are treated as `"_"` in the output, but not if they are the separator of a decimal.

You can achieve this, while passing a regex (in this case a lookaround) to the `preprocess` argument, which only translates those dots into `"_"`, that don't have a digit in front. The resulting underscores between the digits can be cleaned via `protect = "\\d"`:

``` r
to_any_case(c("va.riable.1.2"), case = "snake", preprocess = "(?<!\\d)\\.", protect = "\\d")
## [1] "va_riable1.2"

# you could also use a postprocess in between
to_any_case(c("va.riable.1.2"), case = "snake", preprocess = "(?<!\\d)\\.", postprocess = "//", protect = "\\d")
## [1] "va//riable1.2"
```

<!--

```r
library(snakecase)

strings <- c("smallCamelCase", "BigCamelCase", "SCREAMING_SNAKE_CASE",
             "RRRProjectRRProject", "große Männer_1.2_3-4/5", NA)

# conversion
to_snake_case(strings)
## [1] "small_camel_case"             "big_camel_case"              
## [3] "screaming_snake_case"         "rrr_project_rr_project"      
## [5] "große_männer_1_._2_3_-_4_/_5" NA

to_small_camel_case(strings)
## [1] "smallCamelCase"      "bigCamelCase"        "screamingSnakeCase" 
## [4] "rrrProjectRrProject" "großeMänner1.23-4/5" NA

to_big_camel_case(strings)
## [1] "SmallCamelCase"      "BigCamelCase"        "ScreamingSnakeCase" 
## [4] "RrrProjectRrProject" "GroßeMänner1.23-4/5" NA

to_screaming_snake_case(strings)
## [1] "SMALL_CAMEL_CASE"              "BIG_CAMEL_CASE"               
## [3] "SCREAMING_SNAKE_CASE"          "RRR_PROJECT_RR_PROJECT"       
## [5] "GROSSE_MÄNNER_1_._2_3_-_4_/_5" NA

to_any_case(strings,
            case = "big_camel", 
            preprocess = "\\.|-|/", 
            replace_special_characters = TRUE)
## [1] "SmallCamelCase"      "BigCamelCase"        "ScreamingSnakeCase" 
## [4] "RrrProjectRrProject" "GrosseMaenner12345"  NA

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
-->
Design Philosophy
=================

Practical influences
--------------------

Conversion to a specific target case is not always obvious or unique. In general a clean conversion can only be guaranteed, when the input-string is meaningful.

Take for example a situation where you have IDs for some customers. Instead of calling the column "CustomerID" you abbreviate it to "CID". Without further knowledge about the meaning of CID it will be impossible to know that it should be converted to "c\_id", when using `to_snake_case()`. Instead it will be converted to:

``` r
to_snake_case("CID")
## [1] "cid"
```

We could have also converted to "c\_i\_d" and if we don't know the meaning of "CID", we can't decide which one is the better solution. However it is easy to exclude specific approaches by counterexamples. So in practice it might be nicer to convert "SCREAMING\_SNAKE\_CASE" to "screaming\_snake\_case" instead of "s\_c\_r\_e\_a\_m\_i\_n\_g\_s\_n\_a\_k\_e\_c\_a\_s\_e" (or "screamin\_g\_snak\_e\_cas\_e" or "s\_creaming\_s\_nake\_c\_ase"), which means that also "cid" is preferable to "c\_i\_d" (or "c\_id" or "ci\_d") without further knowledge.

Since the computer can't know, that we want "c\_id" by himself. It is easiest, if we provide him with the right information (here in form of a valid PascalCase syntax):

``` r
to_snake_case("CId")
## [1] "c_id"
```

In this way it is guaranteed to get the correct conversion and the only chance of an error lies in an accidentally wrong provided input string or a bug in the converter function `to_snake_case()`.

Consistent behaviour
--------------------

In many scenarios the analyst doesn't have a big influence on naming conventions and sometimes there might occur situations where it is not possible to find out the exact meaning of a variable name, even if we ask the original author. In some cases data might also have been named by a machine and the results can be relatively technically. So in general it is a good idea to compare the input of the case converter functions with their output, to see if the intended meanings at least seem to be preserved.

To make this as painless as possible, it is best to provide a logic that is robust and can handle also relatively complex cases. Note for example the string "RStudio". How should one convert it to snake case? We have seen a similar example with "CId", but for now we focus on sth. different. In case of "RStudio", we could convert to:

1.  "r\_s\_tudio",
2.  "rs\_tudio" or
3.  "r\_studio".

If we are conservative about any assumptions on the meaning of "RStudio", we can't decide which is the correct conversion. It is also not valid to assume that "RStudio" was intentionally written in PascalCase. Of course we know that "r\_studio" is the correct solution, but we can get there also via different considerations. Let us try to convert our three possible translations (back) to PascalCase and from there back to snake case. What should the output look like?

1.  r\_s\_tudio -&gt; RSTudio -&gt; r\_s\_t\_udio
2.  rs\_tudio -&gt; RsTudio -&gt; rs\_tudio
3.  r\_studio -&gt; RStudio -&gt; r\_studio

Both of the first two alternatives can't be consistently converted back to a valid Pascal case input ("RStudio") and with the first logic the further snake case conversion seems to be complete nonsense. Only the latter case is consistent, when converting back to PascalCase, which is the case of the input "RStudio". It is also consistent to itself, when converting from PascalCase back to snake\_case.

In this way, we can get a good starting point on how to convert specific strings to valid snake\_case. Once we have a clean snake\_case conversion, we can easily convert further to smallCamelCase, BigCamelCase, SCREAMING\_SNAKE\_CASE or anything else.

Three rules of consistency
--------------------------

In the last sections we have seen, that it is reasonable to bring a specific conversion from an input string to some standardized case into question. We have also seen, that it is helpful to introduce some tests on the behavior of a specific conversion pattern in related cases. The latter can help to detect inappropriate conversions and also establishes a consistent behavior when converting exotic cases or switching between standardized cases. Maybe we can generalize some of these tests and introduce some kind of consistency patterns. This would enable us that whenever inappropriate or non-unique possibilities for conversions appear, we have rules that help us to deal with this situation and help to exclude some inconsistent conversion alternatives.

During the development of this package I recognized three specific rules that seem reasonable to be valid whenever cases are converted. To be more general we just use `to_x()` and `to_y()` to refer to any two differing converter functions from this package.

1.  When we have converted to a standardized case, a new conversion to the case should not change the output:

    `to_x(to_x(string)) = to_x(string)`

2.  When converting to a specific case, it should not matter if a conversion to another case happened already:

    `to_y(to_x(string)) = to_y(string)`

3.  It should always be possible to switch between different cases, without any loss of information:

    `to_x(to_y(to_x(string))) = to_x(string)`

Note that it can easily be shown, that rule three follows from the first and the second rule. However, it seems reasonable to express each by its own, since they all have an interpretation and together they give a really good intuition about the properties of the converter functions.

Testing
=======

To give a meaningful conversion for different cases, we systematically designed test-cases for conversion to snake, small- and big camel case among others. To be consistent regarding the conversion between different cases, we also test the rules above on all test-cases. <!--Note that equality in this equation is only one criterion and it still doesn't
imply a unique solution on how to translate an initial string argument to snake or camel case. (Note that also `to_xxx(string) = to_xxx(string)` seems desirable). However, for the 
following testcases, also these two equations are tested.-->

Related Resources
=================

-   [The state of naming conventions in R, Bååth 2012, R Journal](https://lup.lub.lu.se/search/publication/e324f252-1d1c-4416-ad1f-284d4ba84bf9) [Download article](journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf)
-   [Consistent naming conventions in R, Lovelace 2014, RBloggers](https://www.r-bloggers.com/consistent-naming-conventions-in-r/)
-   [What is your preferred style for naming variables in R?, Stackoverflowquestion 2009](http://stackoverflow.com/questions/1944910/what-is-your-preferred-style-for-naming-variables-in-r)
-   [Are there any official naming conventions in R?, stackoverflowquestion 2012](http://stackoverflow.com/questions/10013545/are-there-any-official-naming-conventions-for-r)
-   [`clean_names()` function](https://github.com/sfirke/janitor/blob/master/R/clean_names.R) from the [janitor package](https://github.com/sfirke/janitor)
-   [`to_camel()` function](https://github.com/Rapporter/rapportools/blob/master/R/utils.R) from the [rapporttools package](https://github.com/Rapporter/rapportools)
