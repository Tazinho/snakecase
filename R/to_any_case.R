#' General case conversion
#' 
#' Function to convert strings to any case
#'
#' @param string A string (for example names of a data frame).
#' 
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
#'  There are four "special" cases available:
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
#'  Works with \code{sep_in}, \code{transliterations}, \code{sep_out}, \code{prefix},
#'   \code{postfix},
#'   \code{empty_fill} and \code{unique_sep}.}
#'  \item{\code{"internal_parsing"}: This case is returning the internal parsing
#'  (suppressing the internal protection mechanism), which means that alphanumeric characters will be surrounded by underscores.
#'  It should only be used in very rare usecases and is mainly implemented to showcase the internal workings of \code{to_any_case()}}
#'  }
#' 
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  useful if parsinoption 1 is needed, but some abbreviations need parsing_option 2.
#'  
#' @param sep_in (short for separator input) A regex supplied as a character (if not \code{NULL}), which will be wrapped internally
#' into \code{stringr::regex()}. All matches will be replaced by underscores (aditionally to 
#' \code{"_"} and \code{" "}, for which this is always true). Underscores can later turned into another separator via \code{sep_out}.
#' 
#' @param parsing_option An integer that will determine the parsing_option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses like option 1 but suppresses "_" around non special characters.
#'  In this way case conversion won't apply after these characters. See examples.}
#'  \item{4: parses like option 1, but digits directly behind/in front non-digits, will stay as is.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#'
#' @param transliterations A character vector (if not \code{NULL}). The entries of this argument
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
#' @param sep_out (short for separator output) String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' 
#' @param unique_sep A string. If not \code{NULL}, then duplicated names will get 
#' a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string
#'  to this argument.
#' 
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#' 
#' @param prefix prefix (string).
#'
#' @param postfix postfix (string).
#'
#' @return A character vector according the specified parameters above.
#'
#' @note \code{to_any_case()} is vectorised over \code{string}, \code{sep_in}, \code{sep_out},
#'  \code{empty_fill}, \code{prefix} and \code{postfix}.
#'  
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
#' to_any_case(strings, case = "internal_parsing")
#' to_any_case(strings, case = "none")
#' 
#' ### Parsing options
#' # the default option makes no sense in this setting
#' to_any_case("HAMBURGcity", case = "parsed", parsing_option = 1)
#' # so the second parsing option is the way to address this example
#' to_any_case("HAMBURGcity", case = "parsed", parsing_option = 2)
#' # By default (option 1) characters are converted after non alpha numeric characters.
#' # This option (5) suppresses this behaviour
#' to_any_case("blaBla.bla", case = "big_camel", parsing_option = 3)
#' # there might be reasons to suppress the parsing, while choosing neither one or two
#' 
#' to_any_case("HAMBURGcity", case = "parsed", parsing_option = 0)
#' 
#' ### Abbreviations
#' to_any_case(c("RSSfeedRSSfeed", "USPassport", "USpassport"), abbreviations = c("RSS", "US"))
#' 
#' ### Separator input
#' string <- "R.St\u00FCdio: v.1.0.143"
#' to_any_case(string)
#' to_any_case(string, case = "snake", sep_in = ":|\\.")
#' to_any_case(string, case = "snake",
#'             sep_in = ":|(?<!\\d)\\.")
#' 
#' ### Transliterations
#' to_any_case("\u00E4ngstlicher Has\u00EA", transliterations = c("german", "Latin-ASCII"))
#' 
#' ### sep_out
#' strings2 <- c("this - Is_-: a Strange_string", "AND THIS ANOTHER_One")
#' to_any_case(strings2, case = "snake", sep_in = "-|\\:", sep_out = " ")
#' to_any_case(strings2, case = "big_camel", sep_in = "-|\\:", sep_out = "//")
#' 
#' ### Pre -and postfix
#' to_any_case(strings2, case = "big_camel", sep_in = "-|\\:", sep_out = "//",
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
                                 "all_caps", "lower_camel", "upper_camel", "internal_parsing", "none"),
                        abbreviations = NULL,
                        sep_in = NULL,
                        parsing_option = 1,
                        transliterations = NULL,
                        sep_out = NULL,
                        unique_sep = NULL,
                        empty_fill = NULL,
                        prefix = "",
                        postfix = ""){
  ### Deprecations:
  # if (!identical(preprocess, NULL)) {
  #   warning("argument preprocess is renamed to sep_in and will be removed in later versions",
  #           call. = FALSE)
  #   if (identical(sep_in, NULL)) {
  #     sep_in = preprocess
  #   }
  # }
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
  string <- preprocess_internal(string, sep_in)
  
  if (case != "none"){
    string <- to_parsed_case_internal(string,
                                      parsing_option = parsing_option)
  } else {
    string <- string %>%
      vapply(stringr::str_replace_all, "","_+", "_", USE.NAMES = FALSE) %>% 
      vapply(stringr::str_replace_all, "","^_|_$", "", USE.NAMES = FALSE)
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
    if(!is.null(transliterations)){
      string <- string %>%
        lapply(function (x) 
          replace_special_characters_internal(x, transliterations, case))
    }
### caseconversion--------------------------------------------------------------
    if(case == "mixed"){
      string <- string %>% 
        lapply(function(x) ifelse(!x %in% abbreviations, 
                           stringr::str_c(stringr::str_sub(x, 1, 1),
                                          stringr::str_sub(x, 2) %>%
                                            stringr::str_to_lower()),
                           x)
        )
      }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "snake"){
      string <- string %>%
        lapply(stringr::str_to_lower)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "big_camel"){
      string <- string %>% lapply(stringr::str_to_lower)
      string <- string %>% 
        lapply(function(x) stringr::str_c(stringr::str_sub(x, 1, 1) %>%
                                          stringr::str_to_upper(),
                                        stringr::str_sub(x, 2)))
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "small_camel"){
      string <- string %>% lapply(stringr::str_to_lower)
      string <- string %>% 
        lapply(function(x) stringr::str_c(stringr::str_sub(x, 1, 1) %>%
                                      stringr::str_to_upper(),
                                    stringr::str_sub(x, 2)))
      string <- string %>%
        vapply(stringr::str_c, "", collapse = " ", USE.NAMES = FALSE) %>% 
        vapply(function(x) stringr::str_c(stringr::str_sub(x, 1, 1) %>%
                                          stringr::str_to_lower(),
                                        stringr::str_sub(x, 2)), "",
               USE.NAMES = FALSE) %>% 
        stringr::str_split(" ")
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "screaming_snake"){
      string <- string %>% lapply(stringr::str_to_upper)
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
      string <- string %>% 
        vapply(function(x) stringr::str_c(x, collapse = "_"), "", USE.NAMES = FALSE)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    # Protect (only internal, not via an argument).
    # Replace all "_" by "" which are around a not alphanumeric character
    if (parsing_option == 4){
      string <- stringr::str_replace_all(string, " ", "")
    }
    
    if (case != "internal_parsing"){
      string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
    }
### ----------------------------------------------------------------------------
}
### postprocessing (ouput separator)s--------------------------------------------
    if(!is.null(sep_out) & !identical(string, character(0))){
      string <- purrr::map2_chr(string,
                                sep_out,
                                ~ stringr::str_replace_all(.x, "_", .y))}
    
    if(is.null(sep_out) & case %in% c("small_camel", "big_camel", 
                                            "lower_upper", "upper_lower")){
      string <- stringr::str_replace_all(string, "(?<!\\d)_|_(?!\\d)", "")
    }
### ____________________________________________________________________________
### "none"
  if(case == "none" & !is.null(transliterations)){
    string <- replace_special_characters_internal(string, transliterations)
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
