#' General case conversion
#' 
#' Function to convert strings to any case
#'
#' @param string A string (for example names of a data frame).
#' @param case The desired target case, provided as one of the following:
#' \itemize{
#'  \item{snake_case: \code{"snake"}}
#'  \item{lowerCamel: \code{"lower_camel"} or \code{"small_camel"}}
#'  \item{UpperCamel: \code{"upper_camel"} or \code{"big_camel"}}
#'  \item{ALL_CAPS: \code{"all_caps"} or \code{"screaming_snake"}}
#'  \item{lowerUPPER: \code{"lower_upper"}}
#'  \item{UPPERlower: \code{"upper_lower"}}
#'  }
#'
#'  There are three "special" cases available:
#' \itemize{
#'  \item{\code{"parsed"}: This case is underlying all other cases. 
#'  Every substring a string consists
#'  of becomes surrounded by an underscore (depending on the \code{parsing_option}).
#'   Underscores at the start and end are trimmed. No lower or 
#'  upper case pattern from the input string are changed.}
#'  \item{\code{"mixed"}: Almost the same as \code{case = "parsed"}. Every letter which is not at the start
#'  or behind an underscore is turned into lowercase. If a substring is set as an abbreviation, it will stay in upper case.}
#'  \item{\code{"none"}: Neither parsing nor case conversion occur. This case might be helpful, when
#'  one wants to call the function for the quick usage of the other parameters.
#'  Works with \code{preprocess}, \code{replace_special_characters}, \code{postprocess}, \code{prefix},
#'   \code{postfix},
#'   \code{empty_fill} and \code{unique_sep}.}
#'  }
#'  
#' @param preprocess A string (if not \code{NULL}) that will be wrapped internally
#' into \code{stringr::regex()}. All matches will be replaced by underscores. Underscores can later turned into another separator via \code{postprocess}.
#' 
#' @param protect A string (default: \code{"_(?![:alnum:])|(?<![:alnum:])_"}).
#' Every internal match to the supplied regular expression won't have an output separator
#' around (in older versions conversions like "sepal_._length" occured by default).
#' This argument should usually never be used anymore. Hence, it will be removed in one of the following versions.
#' If you need to make usage of this argument in your code, pls drop me an email, so that I can see if there might be a better solution.
#' 
#' @param replace_special_characters A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} (like "Latin-ASCII", which is often useful) or names of lookup tables (currently
#' only "german" is supported). In the order of the entries the letters of the input
#'  string will be transliterated via \code{stringi::stri_trans_general()} or replaced via the 
#'  matches of the lookup table.
#' 
#' You should use this feature with care in case of \code{case = "parsed"} and 
#' \code{case = "none"}, since for upper case letters, which have transliterations/replacements
#'  of length 2, the second letter will be transliterated to lowercase, for example Oe, Ae, Ss, which
#'  might not always be what is intended.
#' 
#' @param postprocess String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' @param prefix prefix (string).
#' @param postfix postfix (string).
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#' @param unique_sep A string. If not \code{NULL}, then duplicated names will get 
#' a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string
#'  to this argument.
#' @param parsing_option An integer that will determine the parsing_option.
#' #' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses at the beginning like option 1 and the rest like option 2.}
#'  \item{4: parses at the beginning like option 2 and the rest like option 1.}
#'  \item{5: parses like option 1 but suppresses "_" around non special characters.
#'  In this way case conversion won't apply after these characters. See examples.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#'  
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  useful if parsinoption 1 is needed, but some abbreviations need parsing_option 2.
#' 
#' @return A character vector according the specified parameters above.
#'
#' @note \code{to_any_case()} is vectorised over \code{postprocess}, \code{prefix} and \code{postfix}.
#' \code{postprocess} might follow in the future.
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' ### Cases
#' strings <- c("this Is a Strange_string", "AND THIS ANOTHER_One")
#' to_any_case(strings, case = "snake")
#' to_any_case(strings, case = "lower_camel") # same as "small_camel"
#' to_any_case(strings, case = "upper_camel") # same as "big_camel"
#' to_any_case(strings, case = "all_caps") # same as "screaming_snake"
#' to_any_case(strings, case = "lower_upper")
#' to_any_case(strings, case = "upper_lower")
#' to_any_case(strings, case = "parsed")
#' to_any_case(strings, case = "mixed")
#' to_any_case(strings, case = "none")
#' 
#' ### Parsing options
#' # the default option makes no sense in this setting
#' to_any_case("HAMBURGcity", case = "parsed", parsing_option = 1)
#' # so the second parsing option is the way to address this example
#' to_any_case("HAMBURGcity", case = "parsed", parsing_option = 2)
#' # one can also parse the beginning like parsing_option 1 and the rest like option 2
#' to_any_case("HAMBURGcityGERUsa", case = "parsed", parsing_option = 3)
#' # or starting like parsing_option 2 and for the rest switch to option 1
#' to_any_case("HAMBURGcityGERUsa", case = "parsed", parsing_option = 4)
#' # By default (option 1) characters are converted after non alpha numeric characters.
#' # This option (5) suppresses this behaviour
#' to_any_case("blaBla.bla", case = "big_camel", parsing_option = 5)
#' # there might be reasons to suppress the parsing, while choosing neither one or two
#' 
#' to_any_case("HAMBURGcity", case = "parsed", parsing_option = 0)
#' 
#' ### Abbreviations
#' to_any_case(c("RSSfeedRSSfeed", "USPassport", "USpassport"), abbreviations = c("RSS", "US"))
#' 
#' ### Preprocess
#' string <- "R.St\u00FCdio: v.1.0.143"
#' to_any_case(string)
#' to_any_case(string, case = "snake", preprocess = ":|\\.")
#' to_any_case(string, case = "snake",
#'             preprocess = ":|(?<!\\d)\\.")
#' 
#' ### Replace special characters
#' to_any_case("\u00E4ngstlicher Has\u00EA", replace_special_characters = c("german", "Latin-ASCII"))
#' 
#' ### Postprocess
#' strings2 <- c("this - Is_-: a Strange_string", "AND THIS ANOTHER_One")
#' to_any_case(strings2, case = "snake", preprocess = "-|\\:", postprocess = " ")
#' to_any_case(strings2, case = "big_camel", preprocess = "-|\\:", postprocess = "//")
#' 
#' ### Pre -and postfix
#' to_any_case(strings2, case = "big_camel", preprocess = "-|\\:", postprocess = "//",
#'             prefix = "USER://", postfix = ".exe")
#' 
#' @importFrom magrittr "%>%"
#'
#' @seealso \href{https://github.com/Tazinho/snakecase}{snakecase on github} or 
#' \code{\link{caseconverter}} for some handy shortcuts.
#'
#' @export
#'
to_any_case <- function(string,
                        case = c("snake", "small_camel", "big_camel", "screaming_snake", 
                                 "parsed", "mixed", "lower_upper", "upper_lower",
                                 "all_caps", "lower_camel", "upper_camel", "none"),
                        preprocess = NULL,
                        protect = "_(?![:alnum:])|(?<![:alnum:])_",
                        replace_special_characters = NULL,
                        postprocess = NULL,
                        prefix = "",
                        postfix = "",
                        unique_sep = NULL,
                        empty_fill = NULL,
                        parsing_option = 1,
                        abbreviations = NULL){
  ### Deprecations:
  if (!identical(protect,"_(?![:alnum:])|(?<![:alnum:])_")) {
    warning("argument protect is deprecated; If you really need this argument, pls submit an issue on https://github.com/Tazinho/snakecase", 
              call. = FALSE)
    }
  ### Argument matching and checking
  case <- match.arg(case)
### check input length (necessary for NULL and atomic(0))
  if(identical(stringr::str_length(string), integer())){return(character())}
### ____________________________________________________________________________
### save names-attribute
  string_names <- names(string)
### ____________________________________________________________________________
### helper for "lower_upper", "upper_lower"
  # this helper returns a logical vector with TRUE for the first and every
  # second string of those which contain an alphabetic character
  if(case == "upper_lower" | case == "lower_upper") {
    relevant <- function(string){
      relevant <- string %>% stringr::str_detect("[:alpha:]")
      relevant[relevant] <- rep_len(c(TRUE, FALSE), sum(relevant))
      relevant
    }
  }
### Aliases
  case[case == "all_caps"] <- "screaming_snake"
  case[case == "lower_camel"] <- "small_camel"
  case[case == "upper_camel"] <- "big_camel"
### abbreviation handling
  # mark abbreviation with an underscore behind (in front of the parsing)
  # useful if parsinoption 1 is needed, but some abbreviations need parsing_option 2
  string <- abbreviation_internal(string, abbreviations)
### ____________________________________________________________________________
### preprocess (regex into "_") and parsing (surrounding by "_")
  string <- preprocess_internal(string, preprocess)
  
  if (case != "none"){
    string <- to_parsed_case_internal(string,
                                      parsing_option = parsing_option)
  } else {
    string <- string %>%
      purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
      purrr::map_chr(~ stringr::str_replace_all(.x, "^_|_$", ""))
  }
  
### ____________________________________________________________________________
### "mixed", "snake", "small_camel", "big_camel", "screaming_case", "parsed"
  if(case %in% c("mixed", "snake", "small_camel",
                 "big_camel", "screaming_snake", "parsed",
                 "lower_upper", "upper_lower")){
### split-----------------------------------------------------------------------
    if(case %in% c("mixed", "snake", "screaming_snake", "parsed", "lower_upper", "upper_lower")){
      string <- string %>% stringr::str_split("_")
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case %in% c("small_camel", "big_camel")){
      string <- string %>% 
        stringr::str_split(pattern = "(?<!\\d)_|_(?!\\d)")
    }
### replacement of special characters_------------------------------------------
    if(!is.null(replace_special_characters)){
      string <- string %>%
        purrr::map(~replace_special_characters_internal(.x, replace_special_characters, case))
    }
### caseconversion--------------------------------------------------------------
    if(case == "mixed"){
      string <- string %>% 
        purrr::map(~ifelse(!.x %in% abbreviations, 
                           stringr::str_c(stringr::str_sub(.x, 1, 1),
                                          stringr::str_sub(.x, 2) %>%
                                            stringr::str_to_lower()),
                           .x)
                   )
      }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "snake"){
      string <- string %>%
        purrr::map(~ stringr::str_to_lower(.x))
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "big_camel"){
      string <- string %>% purrr::map(stringr::str_to_lower)
      string <- string %>% 
        purrr::map(~ stringr::str_c(stringr::str_sub(.x, 1, 1) %>%
                                          stringr::str_to_upper(),
                                        stringr::str_sub(.x, 2)))
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "small_camel"){
      string <- string %>% purrr::map(stringr::str_to_lower)
      string <- string %>% 
        purrr::map(~ stringr::str_c(stringr::str_sub(.x, 1, 1) %>%
                                      stringr::str_to_upper(),
                                    stringr::str_sub(.x, 2)))
      string <- string %>%
        purrr::map_chr(stringr::str_c, collapse = " ") %>% 
        purrr::map_chr(~ stringr::str_c(stringr::str_sub(.x, 1, 1) %>%
                                          stringr::str_to_lower(),
                                        stringr::str_sub(.x, 2))) %>% 
        stringr::str_split(" ")
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "screaming_snake"){
      string <- string %>% purrr::map(stringr::str_to_upper)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "lower_upper"){
      string[!is.na(string)] <- purrr::map2(string[!is.na(string)],
                                            purrr::map(string[!is.na(string)],
                                                       ~ relevant(.x)),
                            # odds to lower
                            ~{.x[.y] <- stringr::str_to_lower(.x[.y]);
                            # others to upper
                            .x[!.y] <- stringr::str_to_upper(.x[!.y]);
                            .x}) 
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "upper_lower") {
      string[!is.na(string)] <- purrr::map2(string[!is.na(string)], 
                                            purrr::map(string[!is.na(string)],
                                                       ~ relevant(.x)),
                            # odds to upper
                            ~{.x[.y] <- stringr::str_to_upper(.x[.y]);
                            # others to lower
                            .x[!.y] <- stringr::str_to_lower(.x[!.y]);
                            .x}) 
    }
### collapsing------------------------------------------------------------------
    if(case %in% c("none", "mixed", "snake", "screaming_snake", "parsed",
                   "small_camel", "big_camel", "lower_upper", "upper_lower")) {
      string <- string %>% purrr::map_chr(~stringr::str_c(.x, collapse = "_"))
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    # Protect (only internal, not via an argument).
    # Replace all "_" by "" which are around a not alphanumeric character
    if (!is.null(protect)){
      string <- stringr::str_replace_all(string, protect, "")
    }
### ----------------------------------------------------------------------------
}
### postprocessing--------------------------------------------------------------
    if(!is.null(postprocess) & !identical(string, character(0))){
      string <- purrr::map2_chr(string,
                                postprocess,
                                ~ stringr::str_replace_all(.x, "_", .y))}
    
    if(is.null(postprocess) & case %in% c("small_camel", "big_camel", 
                                            "lower_upper", "upper_lower")){
      string <- stringr::str_replace_all(string, "(?<!\\d)_|_(?!\\d)", "")
    }
### ____________________________________________________________________________
### "none"
  if(case == "none" & !is.null(replace_special_characters)){
    string <- replace_special_characters_internal(string, replace_special_characters)
  }
### ____________________________________________________________________________
### fill empty strings
  if(!is.null(empty_fill) & any(string == "")){
    string[string == ""] <- empty_fill
  }
### ____________________________________________________________________________
### make unique
  if(!is.null(unique_sep))
    string <- make.unique(string, sep = unique_sep)
### ____________________________________________________________________________
### pre and postfix
  string <- stringr::str_c(prefix, string, postfix)
### ____________________________________________________________________________
### set back names-attribute
  names(string) <- string_names
### ____________________________________________________________________________
### return
  string
}
