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
#'  \item{ALL_CAPS: \code{"screaming_snake"} or \code{"all_caps"}}
#'  \item{lowerUPPER: \code{"lower_upper"}}
#'  \item{UPPERlower: \code{"upper_lower"}}
#'  }
#'
#'  There are three "special" cases available:
#' \itemize{
#'  \item{\code{"parsed"}: This case is underlying all other cases. 
#'  Every substring a string consists
#'  of becomes surrounded by an underscore (depending on the \code{parsingoption}).
#'   Underscores at the start and end are trimmed. No lower or 
#'  upper case pattern from the input string are changed.}
#'  \item{\code{"mixed"}: Almost the same as \code{case = "parsed"}. Every letter which is not at the start
#'  or behind an underscore is turned into lowercase.}
#'  \item{\code{"none"}: Neither parsing nor casec onversion occur. This case might be helpful, when
#'  one wants to call the function for the quick usage of the other parameters.
#'  Works with \code{preprocess}, \code{replace_special_characters}, \code{prefix},
#'   \code{postfix},
#'   \code{empty_fill} and \code{unique_sep}.}
#'  }
#'  
#' @param preprocess A string (if not \code{NULL}) that will be wrapped internally
#' into \code{stringr::regex()}. All matches will be replaced by underscores.
#' 
#' @param protect A string (if not \code{NULL}) which is a valid \code{stringr::regex()}. Matches within the input
#' won't have any "_" beside within the output.
#' Note that \code{preprocess} has a higher precedence than protect, 
#' which means that it doesn't make sense to protect sth. which is already replaced
#' via \code{preprocess}.
#' 
#' @param replace_special_characters A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} or names of lookup tables (currently
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
#' @param parsingoption An integer that will determine the parsingoption.
#' #' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses at the beginning like option 1 and the rest like option 2.}
#'  \item{4: parses at the beginning like option 2 and the rest like option 1.}
#'  \item{any other integer: no parsing"}
#'  }
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
#' to_any_case(strings, case = "lower_camel")
#' to_any_case(strings, case = "upper_camel")
#' to_any_case(strings, case = "all_caps")
#' to_any_case(strings, case = "lower_upper")
#' to_any_case(strings, case = "upper_lower")
#' to_any_case(strings, case = "parsed")
#' to_any_case(strings, case = "mixed")
#' to_any_case(strings, case = "none")
#' 
#' ### Parsing options
#' # the default option makes no sense in this setting
#' to_any_case("HAMBURGcity", case = "parsed", parsingoption = 1)
#' # so the second parsing option is the way to address this example
#' to_any_case("HAMBURGcity", case = "parsed", parsingoption = 2)
#' # one can also parse the beginning like parsingoption 1 and the rest like option 2
#' to_any_case("HAMBURGcityGERUsa", case = "parsed", parsingoption = 3)
#' # or starting like parsingoption 2 and for the rest switch to option 1
#' to_any_case("HAMBURGcityGERUsa", case = "parsed", parsingoption = 4)
#' # there might be reasons to suppress the parsing, while choosing neither one or two
#' to_any_case("HAMBURGcity", case = "parsed", parsingoption = 5)
#' 
#' ### Preprocess & protect
#' string <- "R.St\u00FCdio: v.1.0.143"
#' to_any_case(string)
#' to_any_case(string, case = "snake", preprocess = ":|\\.")
#' to_any_case(string, case = "snake", protect = ":|\\.")
#' to_any_case(string, case = "snake",
#'             preprocess = ":|(?<!\\d)\\.",
#'             protect = "\\.")
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
                        protect = NULL,
                        replace_special_characters = NULL,
                        postprocess = NULL,
                        prefix = "",
                        postfix = "",
                        unique_sep = NULL,
                        empty_fill = NULL,
                        parsingoption = 1){
  case <- match.arg(case)
### ____________________________________________________________________________
### helper for "lower_upper", "upper_lower"
  # this helper returns a logical vector with TRUE for the first and every
  # second string of those which contain an alphabetic character
  relevant <- function(string){
    relevant <- string %>% stringr::str_detect("[:alpha:]")
    relevant[relevant] <- rep_len(c(TRUE, FALSE), sum(relevant))
    relevant
  }
### Aliases
  case[case == "all_caps"] <- "screaming_snake"
  case[case == "lower_camel"] <- "small_camel"
  case[case == "upper_camel"] <- "big_camel"
### ____________________________________________________________________________
### preprocess (regex into "_") and parsing (surrounding by "_")
  string <- preprocess_internal(string, preprocess)
  
  if (case != "none"){
    string <- to_parsed_case_internal(string,
                                      parsingoption = parsingoption)
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
### protecthelper (1)-----------------------------------------------------------
# mark end of matches of protect before the caseconversion
    if(!is.null(protect)){
      # in the 2nd line the replacement only can occur, if it didn't appear in the first line
      string <- purrr::map(string, ~stringr::str_replace(.x, stringr::str_c("^(", protect, ")"), "\\1___"))
      string <- purrr::map(string, ~stringr::str_replace(.x, stringr::str_c("(", protect, ")[^_]*$"), "__\\1___"))
    }
### replacement of sp. characters-----------------------------------------------
    if(!is.null(replace_special_characters)){
      string <- string %>%
        purrr::map(~replace_special_characters_internal(.x, replace_special_characters, case))
    }
### caseconversion--------------------------------------------------------------
    if(case == "mixed"){
      string <- string %>% 
        purrr::map(~stringr::str_c(stringr::str_sub(.x, 1, 1),
                                   stringr::str_sub(.x, 2) %>%
                                   stringr::str_to_lower()))}
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "snake"){
      string <- string %>%
        purrr::map(~ stringr::str_to_lower(.x))
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "big_camel"){
      string <- string %>% purrr::map(stringr::str_to_lower)
      string <- string %>% purrr::map(stringr::str_to_title)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "small_camel"){
      string <- string %>% purrr::map(stringr::str_to_lower)
      string <- string %>% purrr::map(stringr::str_to_title)
      string <- string %>%
        purrr::map_chr(stringr::str_c, collapse = " ") %>% 
        purrr::map_chr(~ stringr::str_c(stringr::str_sub(.x, 1, 1) %>%
                                          stringr::str_to_lower(),
                                        stringr::str_sub(.x, 2))) %>% 
        stringr::str_split(" ")
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case == "screaming_snake")
      string <- string %>% purrr::map(stringr::str_to_upper)
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
### protecthelper (2)-----------------------------------------------------------
    if(!is.null(protect)){
      string <- string %>% 
        # mark beginning of matches of protect after the caseconversion
        purrr::map(~stringr::str_replace_all(.x, "([^_]*___)", "__\\1"))
    }
### collapsing------------------------------------------------------------------
    if(case %in% c("mixed", "snake", "screaming_snake", "parsed"))
    string <- string %>% purrr::map_chr(~stringr::str_c(.x, collapse = "_"))
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if(case %in% c("small_camel", "big_camel", "lower_upper", "upper_lower")){
      if(is.null(postprocess)){
        string <- string %>% purrr::map_chr(stringr::str_c, collapse = "")
      } else {
        string <- string %>% purrr::map_chr(stringr::str_c, collapse = "_")
      }
    }
### protect---------------------------------------------------------------------
    if(!is.null(protect)){
      string <- string %>% purrr::map_chr(~stringr::str_replace_all(.x, "_{2,}", ""))
    }
### postprocessing--------------------------------------------------------------
    if(!is.null(postprocess) & !identical(string, character(0))){
      string <- purrr::map2_chr(string,
                                postprocess,
                                ~ stringr::str_replace_all(.x, "_", .y))}
### ----------------------------------------------------------------------------
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
### return
  string
}
