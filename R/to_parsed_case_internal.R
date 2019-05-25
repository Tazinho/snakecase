#' Internal parser, which is relevant for preprocessing, parsing and parsing options
#'
#' @param string A string.
#' @param parsing_option An integer that will determine the parsing option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses like option 1 but suppresses "_" around non alpha-numeric characters. In this way this option suppresses splits and resulting case conversion after these characters.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#' @param numerals A character specifying the alignment of numerals (\code{"middle"}, \code{left}, \code{right} or \code{asis}). I.e. \code{numerals = "left"} ensures that no output separator is in front of a digit.
#' @param abbreviations A character string specifying abbreviations that should be marked to be recognized by later parsing.
#' @param sep_in A character (regular expression) used to specify input separators.
#'  
#' @return A character vector separated by underscores, containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
to_parsed_case_internal <- function(string, parsing_option = 1L, numerals, abbreviations, sep_in){
  ### input checking
  if (parsing_option >= 4L | parsing_option <= -4) {
    stop("parsing_option must be between -4 and +4.", call. = FALSE)
  }

  ### applying parsing functions  
  # case: 1 RRRStudioSStudioStudio -> RRR_Studio_S_Studio_Studio
  parsing_option_1 <- function(string, numerals, sep_in) {
    string <- preprocess_internal(string, sep_in)

    if (numerals == "asis") {
      string <- parse6_mark_digits(string)
    }
    string <- parse1_pat_cap_smalls(string) # RStudio.V11 -> R_Studio_.V11
    string <- parse2_pat_digits(string)     # RStudio.V11 -> RStudio.V_11_
    string <- parse3_pat_caps(string)       # RStudio.V11 -> _RS_tudio.V11
    string <- parse4_pat_cap(string)        # RStudio.V11 -> RStudio._V_11
    string <- parse5_pat_non_alnums(string) # RStudio.V11 -> RStudio_._V11
    string
  }
  parsing_option_1_abbr <- function(string, numerals, sep_in) {
    string <- stringr::str_split(string, "_\\sl|r\\s_")
    string <- lapply(string,
                     function(x) ifelse(stringr::str_detect(x, "^[^\\sl]"),
                                        parsing_option_1(x, numerals = numerals, sep_in = sep_in), 
                                        x)
                     )
    string <- vapply(string, 
                     function(x) stringr::str_c(x, collapse = "_"), "",
                     USE.NAMES = FALSE)
    string <- stringr::str_replace_all(string, "\\sl|r\\s", "")
    string
  }
  
  if ((parsing_option == 1 | parsing_option == -1) & is.null(abbreviations)) {
    string <- parsing_option_1(string = string, numerals = numerals, sep_in = sep_in)
  }
  if ((parsing_option == 1 | parsing_option == -1) & !is.null(abbreviations)) {
    string_index <- stringr::str_detect(string, pattern = "\\s")
    string[string_index] <- parsing_option_1_abbr(string = string[string_index], numerals = numerals, sep_in = sep_in)
    string[!string_index] <- parsing_option_1(string = string[!string_index], numerals = numerals, sep_in = sep_in)
  }
  # case: 2 RRRStudioSStudioStudio -> RRRS_tudio_SS_tudio_Studio
  parsing_option_2 <- function(string, numerals, sep_in) {
    string <- preprocess_internal(string, sep_in)
    
    if (numerals == "asis") {
      string <- parse6_mark_digits(string)
    }
    string <- parse3_pat_caps(string)
    string <- parse1_pat_cap_smalls(string)
    string <- parse2_pat_digits(string)
    string <- parse4_pat_cap(string)
    string <- parse5_pat_non_alnums(string)
    string
  }
  parsing_option_2_abbr <- function(string, numerals, sep_in) {
    string <- stringr::str_split(string, "_\\sl|r\\s_")
    string <- lapply(string,
                     function(x) ifelse(stringr::str_detect(x, "^[^\\sl]"),
                                        parsing_option_2(x, numerals = numerals, sep_in = sep_in), 
                                        x)
    )
    string <- vapply(string, 
                     function(x) stringr::str_c(x, collapse = "_"), "",
                     USE.NAMES = FALSE)
    string <- stringr::str_replace_all(string, "\\sl|r\\s", "")
    string
  }
  
  if ((parsing_option == 2 | parsing_option == -2) & is.null(abbreviations)) {
    string <- parsing_option_2(string = string, numerals = numerals, sep_in = sep_in)
  }
  if ((parsing_option == 2 | parsing_option == -2) & !is.null(abbreviations)) {
    string_index <- stringr::str_detect(string, pattern = "\\s")
    string[string_index] <- parsing_option_2_abbr(string = string[string_index], numerals = numerals, sep_in = sep_in)
    string[!string_index] <- parsing_option_2(string = string[!string_index], numerals = numerals, sep_in = sep_in)
  }
  # case: 3 RRRStudioSStudioStudio -> RRRStudio_SStudio_Studio
  parsing_option_3 <- function(string, numerals, sep_in) {
    string <- preprocess_internal(string, sep_in)
    
    if (numerals == "asis") {
      string <- parse6_mark_digits(string)
    }
    string <- parse7_pat_caps_smalls(string)
    string <- parse8_pat_smalls_after_non_alnums(string)
    string <- parse2_pat_digits(string)
    string <- parse4_pat_cap(string)
    string <- parse5_pat_non_alnums(string)
    string
  }
  parsing_option_3_abbr <- function(string, numerals, sep_in) {
    string <- stringr::str_split(string, "_\\sl|r\\s_")
    string <- lapply(string,
                     function(x) ifelse(stringr::str_detect(x, "^[^\\sl]"),
                                        parsing_option_3(x, numerals = numerals, sep_in = sep_in), 
                                        x)
    )
    string <- vapply(string, 
                     function(x) stringr::str_c(x, collapse = "_"), "",
                     USE.NAMES = FALSE)
    string <- stringr::str_replace_all(string, "\\sl|r\\s", "")
    string
  }
  
  if ((parsing_option == 3 | parsing_option == -3) & is.null(abbreviations)) {
    string <- parsing_option_3(string, numerals, sep_in = sep_in)
  }
  if ((parsing_option == 3 | parsing_option == -3) & !is.null(abbreviations)) {
    string_index <- stringr::str_detect(string, pattern = "\\s")
    string[string_index] <- parsing_option_3_abbr(string = string[string_index], numerals = numerals, sep_in = sep_in)
    string[!string_index] <- parsing_option_3(string = string[!string_index], numerals = numerals, sep_in = sep_in)
    
  }
  # case:6 email1_2 -> email 1_2
  # if (parsing_option == 4) {
  #   string <- parse5_mark_digits(string)
  #   string <- parse1_pat_cap_smalls(string)
  #   string <- parse2_pat_caps2(string)
  #   string <- parse3_pat_cap_lonely(string)
  #   string <- parse4_separate_non_alnums(string)
  # }
  
  ### customize the output
  # remove more than one "_" and starting/ending "_"
  string <- stringr::str_replace_all(string, "_+", "_")

  string <- stringr::str_replace_all(string, "^_|_$", "")
  
  if (parsing_option %in% c(-1, -2, -3)) {
    string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  }
  # return
  string
}
