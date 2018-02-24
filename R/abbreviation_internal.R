#' Internal abbreviation marker, marks abbreviations with an underscore behind.
#' Useful if \code{parsing_option} 1 is needed, but some abbreviations need \code{parsing_option} 2.
#'
#' @param string A string (for example names of a data frame).
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  Useful if \code{parsing_option} 1 is needed, but some abbreviations need \code{parsing_option} 2.
#' 
#' @return A character vector.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
abbreviation_internal <- function(string, abbreviations = NULL){
  if(!is.null(abbreviations)){
    # replace at start
    pattern_start <- stringr::str_c("(", stringr::str_c("^", abbreviations, collapse = "|"), ")", "([^[:upper:]])")
    string <- stringr::str_replace_all(string, pattern_start, replacement = "\\1_\\2")
    # replace in the middle to end
    pattern_middle_end <- stringr::str_c("([^[:upper:]]", stringr::str_c(abbreviations, collapse = "|"), ")", "([^[:upper:]]|$)")
    string <- stringr::str_replace_all(string, pattern_middle_end, replacement = "\\1_\\2")
  }
  string
}
