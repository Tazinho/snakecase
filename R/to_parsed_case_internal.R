#' Functions to convert column names to snake_case
#'
#' @param string A string.
#' @param preprocess Character string that will be wrapped internally into stringr::regex. 
#' All matches will be padded with underscores.
#' 
#' @return A character vector separated by underscores, containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @importFrom magrittr "%>%"
#'
to_parsed_case_internal <- function(string, preprocess = NULL){
  # preprocessing: catch some input that should be handled like underscores
  # too (only spaces by default)
  if(!is.null(preprocess)){
    string <- stringr::str_replace_all(string, preprocess, "_")
  }
  string <- stringr::str_replace_all(string, "[:blank:]", "_")
  parsing_functions <- list(
    # Changes behaviour of the function. Cases like RStudio will be converted
    # to r_studio and not to rstudio anymore. Inserts underscores around groups
    # of big letters with following small letters (and ÄÖÜ, äöüß)
    # and also around every group of digits
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
    # Inserts an "_" everywhere except between combinations of small and capital letters and groups of digits.
    parse4_separate_non_characters = function(string){
      sep_signs_around <- "([\u00C4\u00D6\u00DC[:upper:]\u00E4\u00F6\u00FC\u00DF[:lower:]\\d]*)"
      string <- stringr::str_replace_all(string, sep_signs_around, "_\\1")
      string})
  string <- parsing_functions[["parse1_pat_cap_smalls"]](string)
  string <- parsing_functions[["parse2_pat_caps2"]](string)
  string <- parsing_functions[["parse3_pat_cap_lonely"]](string)
  string <- parsing_functions[["parse4_separate_non_characters"]](string)
  # customize the output: remove more than one "_" and starting/ending "_"
  string <- string %>%
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_|_$", ""))
  # return
  string
}
