#' Internal helper to test the design rules for any string and setting of \code{to_any_case()}
#'
#' @param string A string (for example names of a data frame).
#' @param preprocess String that will be wrapped internally into \code{stringr::regex()}. 
#' All matches will be treated as additional splitting parameters besides the default ones 
#' (\code{"_"} and \code{" "}), when parsing the input string.
#' @param transliterations Logical, if \code{TRUE}, special characters 
#' will be translated to characters which are more likely to be understood by 
#' different programs. For example german umlauts will be translated to ae, oe, ue etc.
#' @param postprocess String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' @param prefix prefix (string).
#' @param postfix postfix (string).
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#' @param unique_sep A string. If it is supplied, then duplicated names will get a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string to this argument.
#' @param parsing_option An integer (1 (default), 2 or 3) that will determine the parsing option.
#' 1: RRRStudio -> RRR_Studio
#' 2: RRRStudio -> RRRS_tudio
#' If another integer is supplied, no parsing regarding the pattern of upper- and lowercase will appear.
#' 
#' @return A character vector separated by underscores, containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
check_design_rule <- function(string, preprocess = NULL,
                             transliterations = FALSE, postprocess = NULL, prefix = "",
                             postfix = "", unique_sep = NULL, empty_fill = NULL, parsing_option = 1){
  test_c <- function(string, case){
    to_any_case(string = string, case = case, preprocess = preprocess, 
                transliterations = transliterations,
                postprocess = postprocess, prefix = prefix, postfix = postfix,
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
