
snakecase <img src="man/figures/snakecase05.png" height="200" align="right">
============================================================================

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/Tazinho/snakecase?branch=master&svg=true)](https://ci.appveyor.com/project/Tazinho/snakecase) [![Travis-CI Build Status](https://travis-ci.org/Tazinho/snakecase.svg?branch=master)](https://travis-ci.org/Tazinho/snakecase) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/snakecase)](https://cran.r-project.org/package=snakecase) <!--[![Coverage Status](https://img.shields.io/codecov/c/github/Tazinho/snakecase/master.svg)](https://codecov.io/github/Tazinho/snakecase?branch=master)--> [![downloads](http://cranlogs.r-pkg.org/badges/snakecase)](http://cranlogs.r-pkg.org/) [![total](http://cranlogs.r-pkg.org/badges/grand-total/snakecase)](http://cranlogs.r-pkg.org/)

Overview
--------

<!--A small package with functions to convert column names of data.frames (or strings
in general) to different cases like snake_case, smallCamel- and BigCamelCase among others. Also high level features for more advanced case conversions are provided via `to_any_case()`.-->
The snakecase package introduces a fresh and straightforward approach on case conversion of strings, based upon a concise design philosophy.

If you don't want to read too much, you could watch this [talk](https://www.youtube.com/watch?v=T6p0l8XzP64) instead.

### Install

``` r
# install snakecase from cran
# install.packages("snakecase")

# or the (stable) development version hosted on github
install.packages("devtools")
devtools::install_github("Tazinho/snakecase")
```

### Basic examples

``` r
library(snakecase)

# default is snake case
to_any_case("veryComplicatedString")
## [1] "very_complicated_string"

# dots and other special signs are parsed as words
to_any_case(names(iris))
## [1] "sepal_._length" "sepal_._width"  "petal_._length" "petal_._width" 
## [5] "species"

# since it is not clear if they are separators
to_any_case(names(iris), preprocess = "\\.")
## [1] "sepal_length" "sepal_width"  "petal_length" "petal_width" 
## [5] "species"

# or decimal marks
to_any_case("var_1.5", protect = "\\.")
## [1] "var_1.5"

# of course other cases are supported and separators can be adjusted
to_any_case(names(iris), preprocess = "\\.", case = "upper_camel", postprocess = " ")
## [1] "Sepal Length" "Sepal Width"  "Petal Length" "Petal Width" 
## [5] "Species"

# all of the cases like: snake, lower_camel, upper_camel, all_caps, lower_upper
# and upper_lower are based on parsed case
to_any_case("THISIsHOW IAmPARSED!", case = "parsed")
## [1] "THIS_Is_HOW_I_Am_PARSED_!"

# be aware that automatic case conversion depends on the input string and it is
# recommended to verify the results. You might want to pipe results into dput()
# and hardcode name changes instead of blindly trusting to_any_case's output.
dput(to_any_case("SomeBAdInput"))
## "some_b_ad_input"
```

### Big picture (a parameterized workflow)

The `to_any_case()` function is the workhorse of the package and basically enables you to convert any string into any case via a well thought process of **parsing** (3 steps), **conversion** (2), **postprocessing** (2) and final **cosmetics** (3). (+some internal details...)

Lets illustrate this on a more complicated example, where we visit each argument of `to_any_case()` once, in the order of the internal steps taken:

``` r
to_any_case(
  ### --------------------------------------------------------------------------
  string = "R.StüdioIDE: v.1.0.143RSSfeed", ################### INPUT STRING ###
  ### --------------------------------------------------------------------------
  ### 1. Parsing 
  abbreviations = "RSS",  # character: surrounds matches with "_"
  ##> "R.StüdioIDE: v.1.0.143_RSS_feed"
  preprocess = ":|(?<!\\d)\\.", # regexp: replaces matches with "_"
  ##> "R_StüdioIDE_ v.1.0.143_RSS_feed"
  parsingoption = 1, # integer: replaces blank characters and surrounds
                     # matches of specific pattern with "_"
  ##> "R_Stüdio_IDE_v_._1_._0_._143_RSS_feed" ################ PARSED STRING ###
  ### --------------------------------------------------------------------------
  ### 2. Conversion
  replace_special_characters = "german", # character: converts special 
                                         # characters into ASCII representation
  ##> "R_Stuedio_IDE_v_._1_._0_._143_RSS_feed"
  case = "snake", # character: converts the word/character pattern into a 
                  # specific case and the regarding separator (depending on the 
                  # case)
  ##> "r_stuedio_ide_v_._1_._0_._143_rss_feed" ############ CONVERTED STRING ###
  ### --------------------------------------------------------------------------
  ### 3. Postprocessing
  protect = "\\.", # regexp: removes "_" around matches.  
  ##> "r_stuedio_ide_v.1.0.143_rss_feed"
  
  postprocess = " " # character: sets it's argument as a separator
  ##> "r stuedio ide v.1.0.143 rss feed" ############## POSTPROCESSED STRING ###
  ### --------------------------------------------------------------------------
  
  )
```

    ## [1] "r stuedio ide v 1.0.143 rss feed"

Before getting overwhelmed: In most cases the `preprocess`, `replace_special_characters`, `case` and `postprocess` argument should suffice all your needs.

**Further cosmetics**

-   `make_unique` (logical): can be set to `"TRUE"` if you convert several strings at once and want the output to be unique (for example if the output is supposed to be used as column names for a data frame).
-   `prefix` (character): simple prefix
-   `postfix` (character): simple post/suffix

### Vectorisation, speed and special input handling

The snakecase package is internally build up on the [stringr](https://github.com/tidyverse/stringr) package, which means that many powerful features are provided "by default":

-   `to_any_case()` is vectorised over most of its arguments like `string`, `preprocess`, `protect`, `postprocess`, `empty_fill`, `prefix`, `postfix`.
-   internal character operations are super fast c++ (however, a lot of speed is lost due to a more systematic and maintainable implementation)
-   special input like `character(0)`, `NA` etc. is handled in exactly the same consistent and convenient manner as in the stringr package and all its tidy relatives.

Further reading
---------------

For the rest of this Readme, we first provide more detailed description on the usage of each parameter and then dive a bit deeper into the general design philosophy for the parsing patterns implemented into the package.

### Easy cases

There are 8 different cases available. Note that they are all build up on the first ("parsed") case, which (basically) surrounds every word a string consists of by underscores.

(Please also note that the string "RStudio", which I will use here, is already in its "correct spelling" and the following are just artificial examples to familiarize you with the `to_any_case()` function.)

``` r
string <- "RStudio"

to_any_case(string, case = "parsed")
## [1] "R_Studio"

to_any_case(string, case = "snake")
## [1] "r_studio"

to_any_case(string, case = "screaming_snake") # also "all_caps" will work
## [1] "R_STUDIO"

to_any_case(string, case = "small_camel") # also "lower_camel" will work
## [1] "rStudio"

to_any_case(string, case = "big_camel") # also "upper_camel" will work
## [1] "RStudio"

to_any_case(string, case = "lower_upper")
## [1] "rSTUDIO"

to_any_case(string, case = "upper_lower")
## [1] "Rstudio"

to_any_case(string, case = "mixed")
## [1] "R_Studio"

# the "none" case is provided for the (exclusive) usage of the other function arguments
to_any_case(string, case = "none")
## [1] "RStudio"
```

For these simple cases (except for `case = "none"`) also the shortcuts `to_parsed_case()`, `to_snake_case()`, `to_screaming_snake_case()` etc. are provided, which achieve exactly the same as `to_any_case(string, case)`.

### Customize output

#### Postprocessing

By default the separators of the output are `"_"` or `""` (depending on the case). You can customize this, while supplying another separator to the `postprocess` argument

``` r
string = "RStudio"

to_any_case(string, case = "snake", 
            postprocess = ".")
## [1] "r.studio"

to_any_case(string, case = "big_camel", 
            postprocess = "-")
## [1] "R-Studio"

to_any_case(string, case = "parsed", 
            postprocess = " ")
## [1] "R Studio"
```

Note that the latter example has a nice application for the annotation of graphics. "RStudio" is not a good example for this, since it is a name of a company and already written correctly. But for typical column names this could be a nice way to (almost) automate the conversion from internal (naming conventions in personal development workflow) to external (naming conventions for business reports etc.) representation.

### Parsing options

Above "RStudio" was parsed to "R\_Studio". This is a deliberate choice, but also other parsing options are implemented, which make more sense, when for example different words are separated completely by switching between upper and lower case.

``` r
# the default case makes no sense in this setting
to_any_case("HAMBURGcity", case = "parsed", parsingoption = 1)
## [1] "HAMBUR_Gcity"

# so the second parsing option is the way to address this example
to_any_case("HAMBURGcity", case = "parsed", parsingoption = 2)
## [1] "HAMBURG_city"

# one can also parse the beginning like parsingoption 1 and the rest like option 2
to_any_case("HAMBURGcityGERUsa", case = "parsed", parsingoption = 3)
## [1] "HAMBURG_city_GERU_sa"

# or starting like parsingoption 2 and for the rest switch to option 1
to_any_case("HAMBURGcityGERUsa", case = "parsed", parsingoption = 4)
## [1] "HAMBURG_city_GER_Usa"

# there might be reasons to suppress the parsing, while choosing neither one or two
to_any_case("HAMBURGcity", case = "parsed", parsingoption = 5)
## [1] "HAMBURGcity"
```

In general only parsing options are implemented, which fulfill the design rules of this package, as mentioned below.

### Abbreviations

Parsing options might be a bit of an overkill. Most of the time parsing option 1 (default) should be enough and only in special cases, mostly abbreviations, like "ID", "EN", "US", "NBA" etc. some kind of mixed cases are used with intention. So to overcome this ambiguous cases it might be a good idea to let `to_any_case` know in advance (hardcoded), which abbrevations you make usage of. This can be done via the `abbreviations` argument.

``` r
to_any_case(c("RSSfeedRSSfeed", "RSSFeedRSSFeed",
              "USPassport", "USpassport"), 
            abbreviations = c("RSS", "US"))
## [1] "rss_feed_rss_feed" "rss_feed_rss_feed" "us_passport"      
## [4] "us_passport"
```

### More complex cases

Till now, we only looked at an easy example. By default the parsing of this package recognizes patterns of switching from lower- to uppercase (and vice versa), underscores and spaces or tabs as word boundaries. If we introduce other characters like dots or colons in our strings, the following will happen:

``` r
string <- "R.Stüdio: v.1.0.143"

to_any_case(string, case = "snake")
## [1] "r_._stüdio_:_v_._1_._0_._143"
```

Every single character, which is not a letter, digit, underscore or blank character (tab/whitespace), will be treated like a word and surrounded by underscores. This is intended, since it is not clear, if, for example a dot, is meant to be

-   a separator and should be replaced by an underscore or
-   a decimal mark and should just be kept as it is (without underscores around it).

#### Preprocess & protect

If you would like to treat dots and colons as separators, you can supply them (as a regular expression) to the `preprocess` argument (now they will be internally replaced by underscores, before the parsing occurs)

``` r
to_any_case(string, case = "snake", preprocess = ":|\\.")
## [1] "r_stüdio_v_1_0_143"
```

If you just want to keep them, since they have a special meaning and are not meant to be separators, you can supply them (also as a regular expression) to the `protect` argument (now the underscores around the protected arguments will be deleted)

``` r
to_any_case(string, case = "snake", protect = ":|\\.")
## [1] "r.stüdio:v.1.0.143"
```

If you want to suppress underscores around non alphanumeric characters in general, just supply `protect = "[^[:alnum:]]"`.

Of course you can also combine `preprocess` & `protect` and since these arguments take regular expressions as input, `to_any_case()` becomes very flexible.

You could for example treat only those dots as separators, which are not behind a number and keep the others as decimal marks

``` r
to_any_case(string, case = "snake",
            preprocess = ":|(?<!\\d)\\.",
            protect = "\\.")
## [1] "r_stüdio_v_1.0.143"
```

#### Special characters

If you have problems with special characters (like u umlaut) on your platform, you can replace them via `replace_special_characters = c("german", "Latin-ASCII")`:

``` r
to_any_case(string, case = "snake", 
            preprocess = ":|(?<!\\d)\\.",
            protect = "\\.",
            replace_special_characters = c("german", "Latin-ASCII"))
## [1] "r_stuedio_v_1.0.143"
```

You can supply any id from `stringi::stri_trans_list()` or countryname from the internal transliteration dictionary of this package (currently only "german"; also in combination).

#### Empty or non unique output

You can fill empty results with arbitrary strings via the `empty_fill` argument

``` r
to_any_case(c("","_","."), empty_fill = c("empty", "also empty"))
## [1] "empty"      "also empty" "."
```

Duplicated output can be automatically suffixed via an index (starting with the first duplication) and an arbitrary separator supplied to the `unique_sep` argument

``` r
to_any_case(c("same","same","other"), unique_sep = c(">"))
## [1] "same"   "same>1" "other"
```

#### Pre -and postfix

You can set pre -and suffixes:

``` r
to_any_case(string, case = "big_camel", postprocess = "//",
            prefix = "USER://", postfix = ".exe")
## [1] "USER://R//.//Stüdio//://V//.//1//.//0//.//143.exe"
```

Design Philosophy
-----------------

### Practical influences

Conversion to a specific target case is not always obvious or unique. In general a clean conversion can only be guaranteed, when the input-string is meaningful.

Take for example a situation where you have IDs for some customers. Instead of calling the column "CustomerID" you abbreviate it to "CID". Without further knowledge about the meaning of CID it will be impossible to know that it should be converted to "c\_id", when using `to_snake_case()`. Instead it will be converted to:

``` r
to_snake_case("CID")
## [1] "cid"
```

We could have also converted to "c\_i\_d" and if we don't know the meaning of "CID", we can't decide which one is the better solution. However, it is easy to exclude specific approaches by counterexamples. So in practice it might be nicer to convert "SCREAMING\_SNAKE\_CASE" to "screaming\_snake\_case" instead of "s\_c\_r\_e\_a\_m\_i\_n\_g\_s\_n\_a\_k\_e\_c\_a\_s\_e" (or "screamin\_g\_snak\_e\_cas\_e" or "s\_creaming\_s\_nake\_c\_ase"), which means that also "cid" is preferable to "c\_i\_d" (or "c\_id" or "ci\_d") without further knowledge.

Since the computer can't know, that we want "c\_id" by himself. It is easiest, if we provide him with the right information (here in form of a valid PascalCase syntax):

``` r
to_snake_case("CId")
## [1] "c_id"
```

In this way it is guaranteed to get the correct conversion and the only chance of an error lies in an accidentally wrong provided input string or a bug in the converter function `to_snake_case()`.

### Consistent behaviour

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

### Three rules of consistency

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
-------

To give a meaningful conversion for different cases, we systematically designed test-cases for conversion to snake, small- and big camel case among others. To be consistent regarding the conversion between different cases, we also test the rules above on all test-cases. <!--Note that equality in this equation is only one criterion and it still doesn't
imply a unique solution on how to translate an initial string argument to snake or camel case. (Note that also `to_xxx(string) = to_xxx(string)` seems desirable). However, for the 
following testcases, also these two equations are tested.-->

Related Resources
-----------------

-   [The state of naming conventions in R, Bååth 2012, R Journal](https://lup.lub.lu.se/search/publication/e324f252-1d1c-4416-ad1f-284d4ba84bf9) [Download article](journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf)
-   [Consistent naming conventions in R, Lovelace 2014, RBloggers](https://www.r-bloggers.com/consistent-naming-conventions-in-r/)
-   [What is your preferred style for naming variables in R?, Stackoverflowquestion 2009](http://stackoverflow.com/questions/1944910/what-is-your-preferred-style-for-naming-variables-in-r)
-   [Are there any official naming conventions in R?, stackoverflowquestion 2012](http://stackoverflow.com/questions/10013545/are-there-any-official-naming-conventions-for-r)
-   [`clean_names()` function](https://github.com/sfirke/janitor/blob/master/R/clean_names.R) from the [janitor package](https://github.com/sfirke/janitor)
-   [`to_camel()` function](https://github.com/Rapporter/rapportools/blob/master/R/utils.R) from the [rapporttools package](https://github.com/Rapporter/rapportools)
-   [lettercase-pkg](https://cran.r-project.org/web/packages/lettercase/index.html)
