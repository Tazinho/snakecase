#' Internal parser, which is relevant for preprocessing, parsing and parsing options
#'
#' @param string A string.
#' @param parsing_option An integer that will determine the parsing option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses like option 1 but suppresses "_" around non alpha-numeric characters.
#'  In this way this option suppresses splits and resulting case conversion after these characters.}
#'  \item{4: parses like option 1, but digits directly behind/in front non-digits, will stay as is.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#' @param numerals A character specifying the alignment of numerals (\code{"middle"}, \code{left}, \code{right} or \code{asis}). I.e. \code{numerals = "left"} ensures that no output separator is in front of a digit.
#'  
#' @return A character vector separated by underscores, containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
to_parsed_case_internal <- function(string, parsing_option = 1L, numerals = numerals){
  ### input checking
  if (parsing_option >= 5L) {
    stop("parsing_option must be 1,2,3,4 or <= 0 for no parsing.")
  }
  ### preprocessing:
  # catch everything that should be handled like underscores
  # (only spaces by default)
  
  string <- stringr::str_replace_all(string, "[:blank:]", "_")
  
  ### applying parsing functions  
  # case: 1 RRRStudioSStudioStudio -> RRR_Studio_S_Studio_Studio
  if (parsing_option == 1 | parsing_option == 3) {
    if (numerals == "asis") {
      string <- parse5_mark_digits(string)
    }
    string <- parse1_pat_cap_smalls(string)
    string <- parse2_pat_caps2(string)
    string <- parse3_pat_cap_lonely(string)
    string <- parse4_separate_non_characters(string)
  }
  # case: 2 RRRStudioSStudioStudio -> RRRS_tudio_SS_tudio_Studio
  if (parsing_option == 2) {
    if (numerals == "asis") {
      string <- parse5_mark_digits(string)
    }
    string <- parse2_pat_caps2(string)
    string <- parse1_pat_cap_smalls(string)
    string <- parse3_pat_cap_lonely(string)
    string <- parse4_separate_non_characters(string)}
  # case:6 email1_2 -> email 1_2
  if (parsing_option == 4) {
    string <- parse5_mark_digits(string)
    string <- parse1_pat_cap_smalls(string)
    string <- parse2_pat_caps2(string)
    string <- parse3_pat_cap_lonely(string)
    string <- parse4_separate_non_characters(string)
  }
  
  ### customize the output
  # remove more than one "_" and starting/ending "_"
  string <- vapply(string, 
                   stringr::str_replace_all, "", "_+"   , "_", 
                   USE.NAMES = FALSE)
  string <- vapply(string, 
                   stringr::str_replace_all, "", "^_|_$", "" , 
                   USE.NAMES = FALSE) 
  if (parsing_option == 3) {
    string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  }
  # return
  string
}
