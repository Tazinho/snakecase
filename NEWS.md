# snakecase 0.9.2.9002

* **numerals**: new alignment option `"tight"` which allows to suppress all underscores between numerals and letters.
* **improved speed**: time of internal parsing could be reduced about a factor of ten, due to some `vapply` replacements.

# snakecase 0.9.2

* **cases**: added `to_sentence_case()` (same as snake, but first letter is uppercase and default sep_out is space).
* **numerals**: added `numerals` argument to all caseconverters including `to_any_case()` to format the alignment of digits (`middle`, `left`,`right`, `asis`). Therefore `parsing_option` nr 4 might be removed in later releases, as it is the same as `parsing_option = 1` and `numerals = "asis"`.
* **transliterations**: When named character elements are supplied as part of `transliterations`, anyting that mateches the name is replaced by the corresponding value.
* attributes are now preserved (not only names as before)

# snakecase 0.9.1

* CRAN release
* Change default `sep_in` from `NULL` to `"[^[:alnum:]]"`. This will make it easier for beginners and in general also faster to modify cases from names like `names(iris)`. Updated the regarding sections in the vignette and readme.

# snakecase 0.9.0

* CRAN release

* Changes since last update:

  * parsing_options:
    * old parsing_options 3 and 4 are replaced now by new
      * parsing_option 3, which suppresses case conversion around alpha numerics
      * parsing_option 4, which introduces less formatting of numerals in the output,
      and leaves them very close to the way that they appeared in the input strings.
  * abbreviations:
    * they work now more consistent with cases like lower- and upper camel case
  * new converters:
    * `to_swap_case()` is new. Within `to_any_case()` this conversion can be called also via `case = "flip"`.
  * removed deprecated arguments 
    * `replace_special_characters`, which is now called `transliterations`
    * `preprocess`, which is now called `sep_in`
    * `postprocess`, which is now called `sep_out`
  * removed dependencies:
    * purrr and magrittr are not longer dependencies
    * stringr is the only dependency now (including stringi of course).

# snakecase 0.8.4

* Introduced `to_swap_case()`, which is also available in `to_any_case()` via 
  `case = "swap"` or `case = "flip"`

# snakecase 0.8.3.1

* abbreviations work now also in conversions to lower- and upper camel case.

# snakecase 0.8.3

* replaced `parsing_option`s 3 and 4 with 5 and 6. 
* removed __purrr__ dependency
* removed __magrittr__ dependency

# snakecase 0.8.2.9002

* remove `replace_special_characters`, `preprocess` and `postprocess`.

# snakecase 0.8.2.9001

* added parsing option 6, which doesn't surround digits with separators.

# snakecase 0.8.1

* CRAN releases

# snakecase 0.8.0.9000

* some breaking changes:
    * reordering of the arguments of all `to_xxx_case()` functions
    * renaming `preprocess` to `sep_in`, `postprocess` to `sep_out`, 
    `replace_special_characters` to `transliterations`.

# snakecase 0.7.1

* CRAN update

* for changes see V 0.7.0
* additionally fixed obvious bug and forwarded to_xxx_case args to to_any_case

# snakecase 0.7.0

* changes since last CRAN submission include:
    * to_xxx_case shortcuts are now exact wrappers around to_any_case
    * `process` is deprecated after changing implementation and setting a reasonable default.
    * added `abbreviations` argument to `any_case()`
    * case none is now a lot more general for formatting
    * added `abbreviation` specific behaviour for mixed case
    * new parsing_option 5, which suppresses conversion after ., @, etc
    * renaming of:
        * to_small / to_big_camel_case have been renamed to to_lower / to_upper_camel_case. The old names are and will still be supported in to_any_case
        * `parsingoption` to `parsing_option`
    * introduced rule that parsing_option <= 0 suppresses parsing from now on
    * lots of additional tests and smaller bugfixes
    * several documentation updates including help, examples, readme and vignette
    
# snakecase 0.6.2.9000

* all to_xxx_case functions are now exact wrappers of to_any_case
* to_small / to_big_camel_case have been renamed to to_lower / to_upper_camel_case
* minimal vignette update

# snakecase 0.6.1.9000

* more consistency for case none
* bugfix for parsing option 5

# snakecase 0.6.0.9000 

* overhaul readme
* renamed `parsingoption` argument to `parsing_option`
* `process` argument: changed implementation in `to_any_case`, set a reasonable default, implemented the behaviour also in to_xxx shortcut functions, deprecated `process` argument
* make modifications to case none, which allows now more parsing options

# snakecase 0.5.4.9000

* added special behaviour for abbreviations within "mixed_case"

# snakecase 0.5.3.9000

* added abbreviations argument for better mixed case handling

# snakecase 0.5.2.9000

* improve consistency with stringr pkg regarding special input handling
  
  `if(identical(stringr::str_length(string), integer())){return(character())}`

# snakecase 0.5.1

* Changes since last update:
    * `to_any_case()` and shortcuts (`to_xxx_case()` functions) preserve name attribute now
    * R dependency lowered to 3.1

# snakecase 0.5.0.9001

* `to_any_case()` and the other converter function now preserve the names attribute. (Thanks to @strengejacke)

# snakecase 0.5.0

* CRAN update

* Changes since last CRAN submission include:
    * string transliteration via updated `replace_special_character` argument
    * some new cases: "none", "mixed", "upper_lower", "lower_upper"
    * aliases: "all_caps", "lower_camel", "upper_camel"
    * different parsing options
    * several bugfixes
    * improved internal testing
    * internal modularisation

# snakecase 0.4.0.9016

* `case == "none"` works now with `preprocess`.

# snakecase 0.4.0.9015

* fixed bug so that `case = upper_lower` no also works for `NA`'s.

# snakecase 0.4.0.9014

* added shortcutfunctions `to_mixed_case()`, `to_lower_upper_case()` and `to_upper_lower_case()`.

# snakecase 0.4.0.9013

Implemented two further parsing options:

* 3: parses the first UPPER letter group like parsing option 2 and the rest like option 1  
* 4: parses the first UPPERlowercase letter group like parsingoption 1 and the rest like option 2

# snakecase 0.4.0.9012

bug fix in devversion: protect works now for beginning and end of substrings and not anymore only for complete substrings.

# snakecase 0.4.0.9011

Fix bug for `character(0)` in combination with `postprocess`

# snakecase 0.4.0.9010

Input of `replace special character` is now a character vector. It's entries have to be elements of `stringi::stri_trans_list()` or names of the transliteration dictionary list, 
which comes with this package. This update enables users to transliterate strings from different encodings, in a flexible way. For example UTF8 to Ascii, ... .

# snakecase 0.4.0.9009

* provided aliases `"all_caps"`, `"lower_camel"` and `"upper_camel"` for `"screaming_snake"`, `"small_camel"` and `"big_camel"`.

# snakecase 0.4.0.9008

* small bug fix for upper_lower/lower_upper regarding the behaviour for the combination of preprocess and protect (similar to an earlier bug in the camel cases).

# snakecase 0.4.0.9007

* small bug fix for behaviour of upper_lower/lower_upper. Now substrings with 
without alphabetical characters are ignored.

# snakecase 0.4.0.9006

* new implemented cases: "none", "mixed", "upper_lower", "lower_upper".

# snakecase 0.4.0.9005

* empty_fill runs again in the end, before the pre and postprocess
* fixed bug: `to_any_case("r.aStudio", protect = "a", postprocess = "-", case = "big_camel")` will now
correctly return "R-.AStudio" (so the protection will be triggered by the input and not by the output). In contrast `protect = A` will yield in unprotected output (`-A-`)

# snakecase 0.4.0.9004

* empty_fill runs now at the beginning of to any case function (after the first parsing)
and a second parsing is introduced in case anything is filled.

# snakecase 0.4.0.9003

* fixed bug in camelcases, for letters after protected symbols (usually one wouldn't
protect in these cases anyway...)

# snakecase 0.4.0.9002

* implemented `check_design_rule()` (not exported)
* resolved bugs in other design options (also deleted one which is not valid for
screaming snake case)

# snakecase 0.4.0.9001

* included several parsingoptions for `to_any_case()`.  
  __1:__ "RRRStudio" -> "RRR_Studio" stays as default  
  __2:__ "RRRStudio -> RRRS_tudio"  
  __any other number__ will suppress the parsing (only spaces will be converted into "_")

# snakecase 0.4.0.9000

* This is the (stable) development version now. You can find snakecase on cran [here](https://CRAN.R-project.org/package=snakecase)

# snakecase 0.4.0

* CRAN submission

# snakecase 0.3.5.3

* changed order of the customizing arguments of `to_any_case()`

# snakecase 0.3.5.2

* fixed bug for combination of protect and postprocess. Therefore clarified and rewrote the internal order of `to_any_case()`
* resolved all internal build warnings and notes

# snakecase 0.3.5.1

* fixed bug in replace_special_characters combined with screaming snake case.

# snakecase 0.3.5

* any local special characters are now supported.
* added 2 arguments to `to_any_case()`: empty_fill, which allows to fill strings
matching to "" with the supplied string. unique_sep adds an integer suffix separated
with the supplied string, when not `NULL`.
* fixed a bug in to_snake_case_internal(). groups of digits are not separated in
between anymore.
* digits that are not direct next to each other, will be split via "_" in both camel case
versions. This is a meaningful exception. Otherwise information would be lost and
also the consistency rules in the readme wouldn't hold in this case.

# snakecase 0.3.4

* any_case() is now vectorised over pre-/postprocess, pre-/postfix for all case arguments
* introduces protect as (vectorised) argument to to_any_case(). it accepts regular expressions and cleans "_" or whatever the preprocessing did, between matches.
* some more tests, documentation and fixes.

# snakecase 0.3.3

* introduced case = "parsed" in to_any_case()
* introduced to_parsed_case()

# snakecase 0.3.2

* finished vignette (title: Caseconverters) and replaced the usage part in readme with it.
* changed behaviour in snake_case_internal to always treat whitespaces as underscores.
for whitespaces in output postprocess = " " is recommended.

# snakecase 0.3.1

* started testing `to_any_case` and removed a bug.
* added vignette

# snakecase 0.3.0

* supports behaviour for german umlauts on all platforms
* introduced internal function `to_snake_case_internal()` which does the preprocessing and simplifies all other functions (especially `to_any_case()`) a little bit.
* introduced `to_screaming_snake_case()`
* added arguments prefix, postfix and replace_special_characters to `to_any_case()`.
* completely renewed readme
* updated tests and highly modularized all tests. (just to_any_case lacks some tests now and in general more examples testcases have to be written)

# snakecase 0.2.2

* introduced `to_any_case()` (all functionality and documentation provided, but implementation has to be cleaned and also tests have to be written)

# snakecase 0.2.1

* fixed bug: `to_snake_case_dev(c("ssRRss"))` returns now `ss_r_rss` instead of`"ss_r_r_ss"`
* `to_snake_case()` now treats only spaces like underscores now (not dots anymore)
* functionality to treat different stuff like dots will be added via a new function:  
`to_any_case()`, which will wrap the other three and will have pre- and postprocess arguments

# snakecase 0.2.0

* renamed the single input parameters consistent to `string` (without deprecating
the old name before, since the package was in early dev-stage anyway).
* started a to develop and implement consistent logic (which still has to be better documented in the readme)
* introduced tests for more hard coded examples and the logic behind it (still more
hardcoded examples and a third part of the logic have to be tested)
* internal logic has been simplified and modularised a lot, which makes it easier
to maintain and introduce more highlevel features in the future
* added integrated tests via appveyor on windows
* added badges for cran status and codecoverage to readme

# snakecase 0.1.0

* Introduced `to_snake_case()` which converts strings to snake_case.
* added functions `to_small_camel_case()` and `to_big_camel_case()` which internally
build up on `to_snake_case()` and convert to the appropriate target case.
* added basic hard coded tests
* added integrated tests on linux via travis.ci



