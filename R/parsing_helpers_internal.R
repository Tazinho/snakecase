#' Parsing helpers
#' 
#' Mainly for usage within \code{to_parsed_case_internal}
#'
#' @param string A string.
#'  
#' @return A partly parsed character vector.
#' 
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' 
#' @keywords utilities
#' 
#' @name parsing_helpers
#'
#' @rdname parsing_helpers
#' 
parse1_pat_cap_smalls <- function(string) {
# Inserts underscores around groups of one upper case letter followed
# by lower case letters
  pat_cap_smalls <- "([\u00C4\u00D6\u00DC[:upper:]][\u00E4\u00F6\u00FC\u00DF[:lower:]]+|\\d+)"
  string <- stringr::str_replace_all(string, pat_cap_smalls, "_\\1_")
  string}

#' @rdname parsing_helpers
parse2_pat_caps2 <- function(string) {
# Inserts underscores around all capital letter groups with length >= 2
  pat_caps2 <- "([[:upper:]\u00C4\u00D6\u00DC]{2,})"
  string <- stringr::str_replace_all(string, pat_caps2, "_\\1_")
  string}

#' @rdname parsing_helpers
parse3_pat_cap_lonely <- function(string) {
# Inserts underscores around all capital letter groups with length = 1 that
# don't have a capital letter in front of them and a capital or small letter behind them
  pat_cap_lonely <- "([\u00C4\u00D6\u00DC[:upper:]]*[\u00C4\u00D6\u00DC[:upper:]]{1}[\u00C4\u00D6\u00DC[:upper:]\u00E4\u00F6\u00FC\u00DF[:lower:]]*)"
  string <- stringr::str_replace_all(string, pat_cap_lonely, "_\\1_")
  string}

#' @rdname parsing_helpers
parse4_separate_non_characters = function(string){
# Inserts an "_" everywhere except between combinations of small and 
# capital letters and groups of digits.
  sep_signs_around <- "([\u00C4\u00D6\u00DC[:upper:]\u00E4\u00F6\u00FC\u00DF[:lower:]\\d]*)"
  string <- stringr::str_replace_all(string, sep_signs_around, "_\\1")
  string}

#' @rdname parsing_helpers
parse5_mark_digits = function(string) {
# Inserts _ and space between non-alpanumerics and digits
  digit_marker_before <- "(?<=[^_|\\d])(\\d)"
  digit_marker_after  <- "(\\d)(?=[^_|\\d])"
  string <- stringr::str_replace_all(string, digit_marker_before, "_ \\1")
  string <- stringr::str_replace_all(string, digit_marker_after , "\\1 _")
  string
  }
