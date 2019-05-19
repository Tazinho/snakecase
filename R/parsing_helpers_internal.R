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
# Inserts underscores around groups of one upper case followed by lower case letters (or digits)
# RStudio.V11 -> R_Studio_.V11
  pat_cap_smalls <- "([:upper:][:lower:]+)"
  string <- stringr::str_replace_all(string, pat_cap_smalls, "_\\1_")
  string}

#' @rdname parsing_helpers
parse2_pat_digits <- function(string) {
# Inserts underscores around groups of digts
# RStudio.V11 -> RStudio.V_11_ 
  pat_digits <- "(\\d+)"
  string <- stringr::str_replace_all(string, pat_digits, "_\\1_")
  string}

#' @rdname parsing_helpers
parse3_pat_caps <- function(string) {
# Inserts underscores around all capital letter groups with length >= 2
# RStudio.V11 -> _RS_tudio.V11
  pat_caps <- "([:upper:]{2,})"
  string <- stringr::str_replace_all(string, pat_caps, "_\\1_")
  string}

#' @rdname parsing_helpers
parse4_pat_cap <- function(string) {
# Inserts underscores around all capital letter groups with length = 1 that
# don't have a capital letter in front of them and not a capital or small letter behind them
# RStudio.V11 -> RStudio._V_11
  pat_cap <- "((?<![:upper:])[:upper:]{1}(?![[:alpha:]]))"
  string <- stringr::str_replace_all(string, pat_cap, "_\\1_")
  string}

#' @rdname parsing_helpers
parse5_pat_non_alnums = function(string){
# Inserts underscores around non-alphanumerics
# RStudio.V11 -> RStudio_._V11
  pat_non_alnums <- "([^[:alnum:]])"
  string <- stringr::str_replace_all(string, pat_non_alnums, "_\\1_")
  string}

#' @rdname parsing_helpers
parse6_mark_digits = function(string) {
# Inserts _ and space between non-alphanumerics and digits
  digit_marker_before <- "(?<=[^_|\\d])(\\d)"
  digit_marker_after  <- "(\\d)(?=[^_|\\d])"
  string <- stringr::str_replace_all(string, digit_marker_before, "_ \\1")
  string <- stringr::str_replace_all(string, digit_marker_after , "\\1 _")
  string
  }

#' @rdname parsing_helpers
parse7_pat_caps_smalls = function(string) {
  # Inserts underscores around of one or more upper case letters possibly followed by lower case letters
  pat_caps_smalls <- "([:upper:]+[:lower:]*)"
  string <- stringr::str_replace_all(string, pat_caps_smalls, "_\\1_")
  string
  }

#' @rdname parsing_helpers
parse8_pat_smalls_after_non_alnums = function(string) {
  # Inserts underscores around of one or more upper case letters possibly followed by lower case letters
  pat_smalls_after_non_alnums <- "((?<![:alnum:])[:lower:]+)"
  string <- stringr::str_replace_all(string, pat_smalls_after_non_alnums, "_\\1_")
  string
  }
