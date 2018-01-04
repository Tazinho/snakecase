#' Internal parser, which is relevant for preprocessing, parsing and parsing options
#'
#' @param string A string.
#' @param parsing_option An integer that will determine the parsing option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses at the beginning like option 1 and the rest like option 2.}
#'  \item{4: parses at the beginning like option 2 and the rest like option 1.}
#'  \item{5: parses like option 1 but suppresses "_" around non alpha-numeric characters.
#'  In this way this option suppresses splits and resulting case conversion after these characters.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#'  
#' @return A character vector separated by underscores, containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @importFrom magrittr "%>%"
#'
to_parsed_case_internal <- function(string, parsing_option = 1L){
  ### input checking
  if(parsing_option >= 6L){
    stop("parsing_option must be 1,2,3,4,5 or <= 0 for no parsing.")
  }
  ### preprocessing:
  # catch everything that should be handled like underscores
  # (only spaces by default)
  
  string <- stringr::str_replace_all(string, "[:blank:]", "_")
  
  ### define parsing functions
  parsing_functions <- list(
    # Inserts underscores around groups of one upper case letter followed
    # by lower case letters
    parse1_pat_cap_smalls = function(string){
      pat_cap_smalls <- "([\u00C4\u00D6\u00DC[:upper:]][\u00E4\u00F6\u00FC\u00DF[:lower:]]+|\\d+)"
      string <- stringr::str_replace_all(string, pat_cap_smalls, "_\\1_")
      string},
    # Inserts underscores around all capital letter groups with length >= 2
    parse2_pat_caps2 = function(string){
      pat_caps2 <- "([[:upper:]\u00C4\u00D6\u00DC]{2,})"
      string <- stringr::str_replace_all(string, pat_caps2, "_\\1_")
      string},
    # Inserts underscores around all capital letter groups with length = 1 that
    # don't have a capital letter in front of them and a capital or small letter behind them
    parse3_pat_cap_lonely = function(string){
      pat_cap_lonely <- "([\u00C4\u00D6\u00DC[:upper:]]*[\u00C4\u00D6\u00DC[:upper:]]{1}[\u00C4\u00D6\u00DC[:upper:]\u00E4\u00F6\u00FC\u00DF[:lower:]]*)"
      string <- stringr::str_replace_all(string, pat_cap_lonely, "_\\1_")
      string},
    # Inserts an "_" everywhere except between combinations of small and 
    # capital letters and groups of digits.
    parse4_separate_non_characters = function(string){
      sep_signs_around <- "([\u00C4\u00D6\u00DC[:upper:]\u00E4\u00F6\u00FC\u00DF[:lower:]\\d]*)"
      string <- stringr::str_replace_all(string, sep_signs_around, "_\\1")
      string},
    # Inserts underscores around groups of only the first group of one upper case letter
    # followed by lower case letters.
    parse5_pat_cap_smalls_first = function(string){
      pat_cap_smalls_first <- "^([\u00C4\u00D6\u00DC[:upper:]][\u00E4\u00F6\u00FC\u00DF[:lower:]]+|\\d+)"
      string <- stringr::str_replace(string, pat_cap_smalls_first, "_\\1_")
      string},
    # Inserts underscores around the first capital letter group with length >= 2
    parse6_pat_caps2_first = function(string){
      pat_caps2_first <- "^([[:upper:]\u00C4\u00D6\u00DC]{2,})"
      string <- stringr::str_replace(string, pat_caps2_first, "_\\1_")
      string}
  )
  
  ### applying parsing functions  
  # case: 1 RRRStudioSStudioStudio -> RRR_Studio_S_Studio_Studio
  if(parsing_option == 1 | parsing_option == 5){
    string <- parsing_functions[["parse1_pat_cap_smalls"]](string)
    string <- parsing_functions[["parse2_pat_caps2"]](string)
    string <- parsing_functions[["parse3_pat_cap_lonely"]](string)
    string <- parsing_functions[["parse4_separate_non_characters"]](string)
  }
  # case: 2 RRRStudioSStudioStudio -> RRRS_tudio_SS_tudio_Studio
  if(parsing_option == 2){
    string <- parsing_functions[["parse2_pat_caps2"]](string)
    string <- parsing_functions[["parse1_pat_cap_smalls"]](string)
    string <- parsing_functions[["parse3_pat_cap_lonely"]](string)
    string <- parsing_functions[["parse4_separate_non_characters"]](string)}
  # case:3 RRRStudioSStudioStudio -> RRR_Studio_SS_tudio_Studio
  if(parsing_option == 3){
    string <- parsing_functions[["parse5_pat_cap_smalls_first"]](string)
    string <- parsing_functions[["parse2_pat_caps2"]](string)
    string <- parsing_functions[["parse1_pat_cap_smalls"]](string)
    string <- parsing_functions[["parse3_pat_cap_lonely"]](string)
    string <- parsing_functions[["parse4_separate_non_characters"]](string)}
  # case:4 RRRStudioSStudioStudio -> RRRS_tudio_S_Studio_Studio
  if(parsing_option == 4){
    string <- parsing_functions[["parse6_pat_caps2_first"]](string)
    string <- parsing_functions[["parse1_pat_cap_smalls"]](string)
    string <- parsing_functions[["parse2_pat_caps2"]](string)
    string <- parsing_functions[["parse3_pat_cap_lonely"]](string)
    string <- parsing_functions[["parse4_separate_non_characters"]](string)}
  ### customize the output
  # remove more than one "_" and starting/ending "_"
  string <- string %>%
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_|_$", ""))
  if(parsing_option == 5){
    string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  }
  # return
  string
}
