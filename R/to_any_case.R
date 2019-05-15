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
#'  \item{Sentence case: \code{"sentence"}}
#'  \item{Title Case: \code{"title"} - This one is basically the same as "parsed" case below, but in addition it is wrapped into \code{tools::toTitleCase}.}
#'  }
#'
#'  There are five "special" cases available:
#' \itemize{
#'  \item{\code{"parsed"}: This case is underlying all other cases. 
#'  Every substring a string consists
#'  of becomes surrounded by an underscore (depending on the \code{parsing_option}).
#'   Underscores at the start and end are trimmed. No lower or 
#'  upper case pattern from the input string are changed.}
#'  \item{\code{"mixed"}: Almost the same as \code{case = "parsed"}. Every letter which is not at the start
#'  or behind an underscore is turned into lowercase. If a substring is set as an abbreviation, it will stay in upper case.}
#'  \item{\code{"swap"}: Upper case letters will be turned into lower case and vice versa. Also \code{case = "flip"} will work.
#'  Doesn't work with any of the other arguments except \code{unique_sep}, \code{empty_fill}, \code{prefix} and \code{postfix}.}
#'  \item{\code{"random"}: Each letter will be randomly turned into lower or upper case. Doesn't work with any of the other arguments except \code{unique_sep}, \code{empty_fill}, \code{prefix} and \code{postfix}.}
#'  \item{\code{"none"}: Neither parsing nor case conversion occur. This case might be helpful, when
#'  one wants to call the function for the quick usage of the other parameters.
#'  To suppress replacement of spaces to underscores set \code{sep_in = NULL}.
#'  Works with \code{sep_in}, \code{transliterations}, \code{sep_out}, \code{prefix},
#'   \code{postfix},
#'   \code{empty_fill} and \code{unique_sep}.}
#'  \item{\code{"internal_parsing"}: This case is returning the internal parsing
#'  (suppressing the internal protection mechanism), which means that alphanumeric characters will be surrounded by underscores.
#'  It should only be used in very rare use cases and is mainly implemented to showcase the internal workings of \code{to_any_case()}}
#'  }
#' 
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  Useful if \code{parsing_option} 1 is needed, but some abbreviations within the string need \code{parsing_option} 2.
#'  Use this feature with care: One letter abbreviations and abbreviations next to each other may not be handled correctly, since those cases would introduce ambiguity in parsing.
#'  
#' @param sep_in (short for separator input) if character, is interpreted as a
#'  regular expression (wrapped internally into \code{stringr::regex()}). 
#'  The default value is a regular expression that matches any sequence of
#'  non-alphanumeric values. All matches will be replaced by underscores 
#'  (additionally to \code{"_"} and \code{" "}, for which this is always true, even
#'  if \code{NULL} is supplied). These underscores are used internally to split
#'  the strings into substrings and specify the word boundaries.
#'  
#' @param parsing_option An integer that will determine the parsing_option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: This \code{parsing_option} will suppress the conversion after non-alphanumeric
#'  values. See examples.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#'
#' @param transliterations A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} (like "Latin-ASCII", which is often useful) or names of lookup tables (currently
#' only "german" is supported). In the order of the entries the letters of the input
#'  string will be transliterated via \code{stringi::stri_trans_general()} or replaced via the 
#'  matches of the lookup table. When named character elements are supplied as part of `transliterations`, anything that matches the names is replaced by the corresponding value.

#' You should use this feature with care in case of \code{case = "parsed"}, \code{case = "internal_parsing"} and 
#' \code{case = "none"}, since for upper case letters, which have transliterations/replacements
#'  of length 2, the second letter will be transliterated to lowercase, for example Oe, Ae, Ss, which
#'  might not always be what is intended. In this case you can make usage of the option to supply named elements and specify the transliterations yourself.
#' 
#' @param numerals A character specifying the alignment of numerals (\code{"middle"}, \code{left}, \code{right}, \code{asis} or \code{tight}). I.e. \code{numerals = "left"} ensures that no output separator is in front of a digit.
#' 
#' @param sep_out (short for separator output) String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}. When \code{length(sep_out) > 1}, the last element of \code{sep_out} gets recycled and separators are incorporated per string according to their order.
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
#' to_any_case(strings, case = "sentence")
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
#' # This option (3) suppresses this behaviour
#' to_any_case("blaBla.bla", case = "big_camel", parsing_option = 3)
#' # Numbers are always separated from characters via an underscore. 
#' # To suppress this behaviour choose parsing_option 4
#' snakecase::to_any_case("d3 library", case = "upper_camel", parsing_option = 4, sep_out = " ")
#' # there might be reasons to suppress the parsing, while choosing neither one or two
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
#' ### Empty fill and unique sep
#' to_any_case(c("","",""), empty_fill = c("empty", "empty", "also empty"))
#' 
#' to_any_case(c("same", "same", "same", "other"), unique_sep = c(">"))
#' 
#' ### Pre -and postfix
#' to_any_case(strings2, case = "big_camel", sep_in = "-|\\:", sep_out = "//",
#'             prefix = "USER://", postfix = ".exe")
#'
#' @seealso \href{https://github.com/Tazinho/snakecase}{snakecase on github} or 
#' \code{\link{caseconverter}} for some handy shortcuts.
#'
#' @export
#'
to_any_case <- function(string,
                        case = c("snake", "small_camel", "big_camel", "screaming_snake", 
                                 "parsed", "mixed", "lower_upper", "upper_lower", "swap",
                                 "all_caps", "lower_camel", "upper_camel", "internal_parsing", 
                                 "none", "flip", "sentence", "random", "title"),
                        abbreviations = NULL,
                        sep_in = "[^[:alnum:]]",
                        parsing_option = 1,
                        transliterations = NULL,
                        numerals = c("middle", "left", "right", "asis", "tight"),
                        sep_out = NULL,
                        unique_sep = NULL,
                        empty_fill = NULL,
                        prefix = "",
                        postfix = ""){
### ____________________________________________________________________________
### Argument matching
  case <- match.arg(case)
  numerals <- match.arg(numerals)
### ____________________________________________________________________________
### Set encoding to utf8
  string <- enc2utf8(string)
### ____________________________________________________________________________
### Argument checking (check input length -> necessary for NULL and atomic(0))
  if (identical(stringr::str_length(string), integer())) {return(character())}
### ____________________________________________________________________________
### Save attributes
  string_attributes <- attributes(string)
### ____________________________________________________________________________
### Handle aliases
  case[case == "all_caps"] <- "screaming_snake"
  case[case == "lower_camel"] <- "small_camel"
  case[case == "upper_camel"] <- "big_camel"
  case[case == "flip"] <- "swap"
### ____________________________________________________________________________
### Prepare title case
  title <- if (case == "title") TRUE else FALSE
  case[case == "title"] <- "parsed"
### ____________________________________________________________________________
### Handle swap case
  if (case == "swap") {
    string <- gsub(pattern = "([[:upper:]])|([[:lower:]])",
                   perl = TRUE,
                   replacement = "\\L\\1\\U\\2",
                   string)}
### ____________________________________________________________________________
### Handle random case
  if (case == "random") {
    random_case <- function(string) {
      upper_or_lower <- function(string) {
        if(sample(c(TRUE, FALSE), 1)) {return(toupper(string))}
        tolower(string)
      }
      
      unlist(
        lapply(
          strsplit(string, split = character(0)),
          function(x) paste0(unlist(lapply(x, upper_or_lower)), collapse = "")
        )
      )
    }
    
    string <- random_case(string)
  }
### ____________________________________________________________________________
### Match abbreviations
  # mark abbreviation by placing an underscore behind them (in front of the parsing)
  # useful if parsingoption 1 is needed, but some abbreviations need parsing_option 2
  if (!case %in% c("swap", "random")) {
    string <- abbreviation_internal(string, abbreviations)
  }
### ____________________________________________________________________________
### Preprocessing:
## Turn mateches of `sep_in` into "_" and
## surround matechs of the parsing by "_" (parsed_case)
  if (!case %in% c("swap", "random")) {
    string <- preprocess_internal(string, sep_in)
    
    if (case != "none") {
      string <- to_parsed_case_internal(string,
                                        parsing_option = parsing_option,
                                        numerals = numerals)
    } else {
      string <- vapply(string, stringr::str_replace_all, "","_+", "_", 
                       USE.NAMES = FALSE) 
      string <- vapply(string, stringr::str_replace_all, "","^_|_$", "",
                       USE.NAMES = FALSE)
    }
### ____________________________________________________________________________
### "mixed", "snake", "small_camel", "big_camel", "screaming_case", "parsed"
  if (case %in% c("mixed", "snake", "small_camel",
                 "big_camel", "screaming_snake", "parsed",
                 "lower_upper", "upper_lower", "sentence")) {
### split-----------------------------------------------------------------------
    if (case %in% c("mixed", "snake", "screaming_snake", "parsed", "lower_upper", "upper_lower", "sentence")) {
      string <- stringr::str_split(string, "_")
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case %in% c("small_camel", "big_camel")) {
      string <- stringr::str_split(string, pattern = "(?<!\\d)_|_(?!\\d)")
    }
### replacement of special characters_------------------------------------------
    if (!is.null(transliterations)) {
      string <- lapply(string, function(x)
        replace_special_characters_internal(x, transliterations, case))
      string <- lapply(string, function(x) 
        stringr::str_replace_all(x, "_+", "_"))
    }
### caseconversion--------------------------------------------------------------
    if (case == "mixed") {
      string <- lapply(string,
                       function(x) ifelse(!x %in% abbreviations, 
                           stringr::str_c(stringr::str_sub(x, 1, 1),
                                          stringr::str_to_lower(stringr::str_sub(x, 2))),
                           x)
        )
      }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case %in% c("snake", "sentence")) {
      string <- lapply(string, stringr::str_to_lower)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "big_camel") {
      string <- lapply(string, stringr::str_to_lower)
      if (!is.null(abbreviations)) {
      string <- lapply(string, 
                       function(x) ifelse(x %in% stringr::str_to_lower(abbreviations), 
                                          stringr::str_to_upper(x),
                                          x)
      )
      }
      string <- lapply(string,
                       function(x) stringr::str_c(stringr::str_to_upper(stringr::str_sub(x, 1, 1)),
                                                  stringr::str_sub(x, 2)))
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "small_camel") {
      string <- lapply(string, stringr::str_to_lower)
      string <- lapply(string, 
                       function(x) stringr::str_c(stringr::str_to_upper(stringr::str_sub(x, 1, 1)),
                                    stringr::str_sub(x, 2)))
      string <- vapply(string, 
                       stringr::str_c, "", collapse = " ",
                       USE.NAMES = FALSE)
      string <- vapply(string, 
                       function(x) stringr::str_c(stringr::str_to_lower(stringr::str_sub(x, 1, 1)),
                                        stringr::str_sub(x, 2)), "",
               USE.NAMES = FALSE)
      string <- stringr::str_split(string, " ")
      if (!is.null(abbreviations)) { # handle abbreviations
      string <- lapply(string,
                       function(x) c(stringr::str_to_lower(x[1]), 
                                     ifelse(stringr::str_to_lower(x[-1]) %in% stringr::str_to_lower(abbreviations),
                                            stringr::str_to_upper(x[-1]), x[-1])))
      }
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "screaming_snake") {
      string <- lapply(string, stringr::str_to_upper)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "lower_upper") {
      string[!is.na(string)] <- mapply(function(x, y) { 
        # odds to lower
        x[y] <- stringr::str_to_lower(x[y]);
        # others to upper
        x[!y] <- stringr::str_to_upper(x[!y]);
        x},
        string[!is.na(string)],
        lapply(string[!is.na(string)], relevant),
        SIMPLIFY = FALSE,
        USE.NAMES = TRUE)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    if (case == "upper_lower") {
      string[!is.na(string)] <- mapply(function(x, y) {
        # odds to upper
        x[y] <- stringr::str_to_upper(x[y]);
        # others to lower
        x[!y] <- stringr::str_to_lower(x[!y]);
        x},
        string[!is.na(string)],
        lapply(string[!is.na(string)], relevant),
        SIMPLIFY = FALSE,
        USE.NAMES = TRUE)
    }
### collapsing------------------------------------------------------------------
    if (case %in% c("none", "mixed", "snake", "screaming_snake", 
                   "small_camel", "big_camel", "lower_upper", "upper_lower") | 
        (case == "parsed" & !title)) {
      string <- vapply(string, 
                       function(x) stringr::str_c(x, collapse = "_"), "",
                       USE.NAMES = FALSE)
    }
    
    if (case == "parsed" & title){
      string <- vapply(string, 
                       function(x) stringr::str_c(x, collapse = " "), "",
                       USE.NAMES = FALSE)
      string <- tools::toTitleCase(string)
      string <- stringr::str_replace_all(string, " ", "_")
    }
    
    if (case == "sentence") {
      string <- vapply(string, 
                       function(x) stringr::str_c(x, collapse = "_"), "",
                       USE.NAMES = FALSE)
    }
    #. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    # Protect (only internal, not via an argument).
    # Replace all "_" by "" which are around a not alphanumeric character
    if (parsing_option == 4 | numerals == "asis") {
      string <- stringr::str_replace_all(string, " ", "")
    }
    if (numerals == "right" | numerals == "tight") {
      # underscore with a digit before and no digit after
      string <- stringr::str_replace_all(string, "(?<=\\d)_(?!\\d)", "")
    }
    
    if (numerals == "left" | numerals == "tight") {
      # underscore with no digit before and a digit after
      string <- stringr::str_replace_all(string, "(?<!\\d)_(?=\\d)", "")
    }
    
    # omit (old) protection mode
    if (case != "internal_parsing") {
      string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
    }
### ----------------------------------------------------------------------------
}
### postprocessing (ouput separator)s--------------------------------------------
    # if (!is.null(sep_out) & !identical(string, character(0))) {
    #   string <- mapply(function(x, y) 
    #     stringr::str_replace_all(x, "_", y),
    #                              string,
    #                              sep_out,
    #     USE.NAMES = FALSE)
    #   }
    if (!is.null(sep_out) & !identical(string, character(0))) {
      paste_along <- function(x, along = "_") {
        if (length(x) <= 1L) return(x)
        if (length(along) == 1L) return(paste0(x, collapse = along))
        
        along <- c(along, rep_len(along[length(along)], max(length(x) - length(along), 0L)))
        paste0(paste0(x[seq_len(length(x) - 1)], along[seq_len(length(x) - 1)] ,
                      collapse = ""), x[length(x)])
      }
      
      string <- stringr::str_split(string, pattern = "_")
      string <- vapply(string, 
                       function(x) paste_along(x, along = sep_out), "",
                       USE.NAMES = FALSE)
    }
    
    if (is.null(sep_out) & case %in% c("small_camel", "big_camel", 
                                            "lower_upper", "upper_lower")) {
      string <- stringr::str_replace_all(string, "(?<!\\d)_|_(?!\\d)", "")
    }
    
    if (is.null(sep_out) & (case == "sentence" | (case == "parsed" & title))) {
      string <- stringr::str_replace_all(string, "_", " ")
    }

    if (case == "sentence") {
      string <- vapply(string, 
                       function(x) stringr::str_c(stringr::str_to_upper(stringr::str_sub(x, 1, 1)),
                                                  stringr::str_sub(x, 2)), "",
                       USE.NAMES = FALSE)
    }
### ____________________________________________________________________________
### "none"
  if (case == "none" & !is.null(transliterations)) {
    string <- replace_special_characters_internal(string, transliterations, case = case)
  }
### ____________________________________________________________________________    
} # close swap
### ____________________________________________________________________________
### fill empty strings
  if (!is.null(empty_fill) & any(string == "")) {
    string[string == ""] <- empty_fill
  }
### ____________________________________________________________________________
### make unique
  if (!is.null(unique_sep)) {
    string <- make.unique(string, sep = unique_sep)
  }
### ____________________________________________________________________________
### pre and postfix
  string <- stringr::str_c(prefix, string, postfix)
### ____________________________________________________________________________
### set back attributes
  attributes(string) <- string_attributes
### ____________________________________________________________________________
### guarantee that output is really UTF-8
  string <- enc2utf8(string)
### ____________________________________________________________________________
### return
  string
}
