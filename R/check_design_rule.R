#' Internal helper to test the design rules for any string and setting of \code{to_any_case()}
#'
#' @param string A string (for example names of a data frame).
#' @param sep_in String that will be wrapped internally into \code{stringr::regex()}. 
#' All matches will be treated as additional splitting parameters besides the default ones 
#' (\code{"_"} and \code{" "}), when parsing the input string.
#' @param transliterations A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} (like "Latin-ASCII", which is often useful) or names of lookup tables (currently
#' only "german" is supported). In the order of the entries the letters of the input
#'  string will be transliterated via \code{stringi::stri_trans_general()} or replaced via the 
#'  matches of the lookup table.
#' @param sep_out String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' @param prefix prefix (string).
#' @param postfix postfix (string).
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#' @param unique_sep A string. If it is supplied, then duplicated names will get a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string to this argument.
#' @param parsing_option An integer that will determine the parsing_option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses at the beginning like option 1 and the rest like option 2.}
#'  \item{4: parses at the beginning like option 2 and the rest like option 1.}
#'  \item{5: parses like option 1 but suppresses "_" around non special characters.
#'  In this way case conversion won't apply after these characters. See examples.}
#'  \item{6: parses like option 1, but digits directly behind/in front non-digits, will stay as is.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#' 
#' @return A character vector separated by underscores, containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
check_design_rule <- function(string, sep_in = NULL,
                             transliterations = NULL, sep_out = NULL, prefix = "",
                             postfix = "", unique_sep = NULL, empty_fill = NULL, parsing_option = 1){
  test_c <- function(string, case){
    to_any_case(string = string, case = case, sep_in = sep_in, 
                transliterations = transliterations,
                sep_out = sep_out, prefix = prefix, postfix = postfix,
                unique_sep = unique_sep, empty_fill = empty_fill, 
                parsing_option = parsing_option)
  }
  all(
    # snake
    test_c(string, case = "snake") == test_c(test_c(string, case = "snake"), case = "snake"),
    test_c(string, case = "snake") == test_c(test_c(string, case = "small_camel"), case = "snake"),
    test_c(string, case = "snake") == test_c(test_c(string, case = "big_camel"), case = "snake"),
    test_c(string, case = "snake") == test_c(test_c(string, case = "screaming_snake"), case = "snake"),
    # small_camel
    test_c(string, case = "small_camel") == test_c(test_c(string, case = "snake"), case = "small_camel"),
    test_c(string, case = "small_camel") == test_c(test_c(string, case = "small_camel"), case = "small_camel"),
    test_c(string, case = "small_camel") == test_c(test_c(string, case = "big_camel"), case = "small_camel"),
    test_c(string, case = "small_camel") == test_c(test_c(string, case = "screaming_snake"), case = "small_camel"),
    # big_camel
    test_c(string, case = "big_camel") == test_c(test_c(string, case = "snake"), case = "big_camel"),
    test_c(string, case = "big_camel") == test_c(test_c(string, case = "small_camel"), case = "big_camel"),
    test_c(string, case = "big_camel") == test_c(test_c(string, case = "big_camel"), case = "big_camel"),
    test_c(string, case = "big_camel") == test_c(test_c(string, case = "screaming_snake"), case = "big_camel"),
    # screaming_snake
    test_c(string, case = "screaming_snake") == test_c(test_c(string, case = "snake"), case = "screaming_snake"),
    test_c(string, case = "screaming_snake") == test_c(test_c(string, case = "small_camel"), case = "screaming_snake"),
    test_c(string, case = "screaming_snake") == test_c(test_c(string, case = "big_camel"), case = "screaming_snake"),
    test_c(string, case = "screaming_snake") == test_c(test_c(string, case = "screaming_snake"), case = "screaming_snake")
  )
  }
