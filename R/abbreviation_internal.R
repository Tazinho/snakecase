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

  if (!is.null(abbreviations)) {
    abbreviations_upper <- stringr::str_to_upper(abbreviations)
    
    if (length(abbreviations_upper)) {
      # replace at start
      pattern_start <- stringr::str_c("(", stringr::str_c("^", abbreviations_upper, collapse = "|"), ")", "(?=[^[:upper:]])")
      string <- stringr::str_replace_all(string, pattern_start, replacement = "_ l l\\1r r _")
      # replace in the middle
      pattern_middle <- stringr::str_c("(?<=[^[:upper:]])(", stringr::str_c(abbreviations_upper, collapse = "|"), ")", "(?=[^[:upper:]])")
      string <- stringr::str_replace_all(string, pattern_middle, replacement = "_ l l\\1r r _")
      # replace in the end
      pattern_end <- stringr::str_c("(?<=[^[:upper:]])(", stringr::str_c(abbreviations_upper, "$", collapse = "|"), ")")
      string <- stringr::str_replace_all(string, pattern_end, replacement = "_ l l\\1r r _")
      # replace from start to end
      pattern_start_to_end <- stringr::str_c("^(", stringr::str_c(abbreviations_upper, "$", collapse = "|"), ")")
      string <- stringr::str_replace_all(string, pattern_start_to_end, replacement = "_ l l\\1r r _")
    }
    
    abbreviations_lower <- stringr::str_to_lower(abbreviations)
    if (length(abbreviations_lower)) {
      # replace at start
      pattern_start <- stringr::str_c("(", stringr::str_c("^", abbreviations_lower, collapse = "|"), ")", "(?=[^[:lower:]])")
      string <- stringr::str_replace_all(string, pattern_start, replacement = "_ l l\\1r r _")
      # replace in the middle
      pattern_middle <- stringr::str_c("(?<=[^[:lower:]])(", stringr::str_c(abbreviations_lower, collapse = "|"), ")", "(?=[^[:lower:]])")
      string <- stringr::str_replace_all(string, pattern_middle, replacement = "_ l l\\1r r _")
      # replace in the end
      pattern_end <- stringr::str_c("(?<=[^[:lower:]])(", stringr::str_c(abbreviations_lower, "$", collapse = "|"), ")")
      string <- stringr::str_replace_all(string, pattern_end, replacement = "_ l l\\1r r _")
      # replace from start to end
      pattern_start_to_end <- stringr::str_c("^(", stringr::str_c(abbreviations_lower, "$", collapse = "|"), ")")
      string <- stringr::str_replace_all(string, pattern_start_to_end, replacement = "_ l l\\1r r _")
    }
  }
  
  string <- stringr::str_replace_all(string, "(_\\sl\\sl)+", "_ l l")
  # string <- stringr::str_replace_all("_ l l_ l lRSSr r _r r _feed_ l lRSSr r _feed", "(_\\sl\\sl)+", "_ l l")
  string <- stringr::str_replace_all(string, "(r\\sr\\s_)+", "r r _")
  string
}
