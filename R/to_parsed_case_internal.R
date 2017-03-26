#' Functions to convert column names to snake_case
#'
#' @param string Character string indicating column names of a data.frame.
#' @param preprocess Character string that will be wrapped internally into stringr::regex. All matches will be
#' treated like underscore. This is useful and gives flexibility to customize conversion
#' of strings that contain also dots, hyphens and/or other special characters.
#'
#' @return Vector of character strings in snake_case
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
  string <- stringr::str_replace_all(string, "\\s", "_")
  parsing_functions <- list(
    # Changes behaviour of the function. Cases like RStudio will be converted
    # to r_studio and not to rstudio anymore. Inserts underscores around groups
    # of big letters with following small letters (and ÄÖÜ, äöüß)
    parse1_pat_cap_smalls <- function(string){
      pat_cap_smalls <- "([A-Z\u00C4\u00D6\u00DC][a-z\u00E4\u00F6\u00FC\u00DF]+)"
      string <- stringr::str_replace_all(string, pat_cap_smalls, "_\\1_")
      string})
  string <- parse1_pat_cap_smalls(string)
  # Inserts underscores around all capital letter groups with length >= 2
  pat_caps2 <- "([A-Z\u00C4\u00D6\u00DC]{2,})"
  string <- stringr::str_replace_all(string, pat_caps2, "_\\1_")
  # Inserts underscores around all capital letter groups with length = 1 that
  # don't have a capital letter in front of them and a capital or small letter behind them
  pat_cap_lonely <- "([A-Z\u00C4\u00D6\u00DC]*[A-Z\u00C4\u00D6\u00DC]{1}[A-Z\u00C4\u00D6\u00DCa-z\u00E4\u00F6\u00FC\u00DF]*)"
  string <- stringr::str_replace_all(string, pat_cap_lonely, "_\\1_")
  # customize the output to snake case
  # - applying tolower, remove more than one "_" and starting/ending "_"
  string <- string %>%
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_|_$", ""))
  # return
  string
}
