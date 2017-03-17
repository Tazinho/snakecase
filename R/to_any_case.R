#' Functions to convert column names to snake_case
#'
#' @param string Character string indicating column names of a data.frame.
#' @param case Character string ("snake", "small_camel" or "big_camel"), indicating 
#' case should be the target case, that the string should be converted into.
#' @param preprocess Character string that will be wrapped internally into stringr::regex. All matches will be
#' treated like underscore. This is useful and gives flexibility to customize conversion
#' of strings that contain also dots, hyphens and/or other special characters.
#' @param postprocess Character string indicating column names of a data.frame.
#'
#' @return character
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case", "_camel_case__")
#' to_any_case(camelCases)
#' to_any_case_dev("fsdf.d-sf", preprocess = "\\.|-")
#'
#' @importFrom magrittr "%>%"
#'
#' @export
#'
to_any_case <- function(string, case = c("snake", "small_camel", "big_camel"), preprocess = "\\s+", postprocess = "_"){
  preprocess <- stringr::str_c("\\s+|", preprocess)
  # catch some input that should be handled like underscores too (only spaces!)
  string <- stringr::str_replace_all(string, preprocess, "_")
  # Changes behaviour of the function. Cases like RStudio will be converted
  # to r_studio and not to rstudio anymore. Inserts underscores around groups
  # of big letters with following small letters
  string <- stringr::str_replace_all(string, "([A-Z][a-z]+)", "_\\1_")
  # Inserts underscores around all capital letter groups with length >= 2
  string <- stringr::str_replace_all(string, "([A-Z]{2,})", "_\\1_")
  # Inserts underscores around all capital letter groups with length = 1 that
  # don't have a capital letter in front of them
  string <- stringr::str_replace_all(string, "([A-Z]*[A-Z]{1}[A-Za-z]*)", "_\\1_")
  # customize the output to snake case
  # - applying tolower, remove more than one "_" and starting/ending "_"
  string <- string %>% purrr::map_chr(stringr::str_to_lower) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_|_$", ""))
  # caseconversion to small-/big camel case with postprocessing
  if(case == "small_camel" | case == "big_camel"){
    string <- string %>% 
      stringr::str_split("_") %>% 
      purrr::map(stringr::str_to_title) %>% 
      purrr::map_chr(stringr::str_c, collapse = postprocess)
  }
  if(case == "small_camel"){
    string <- string %>% 
      stringr::str_c(stringr::str_sub(string, 1, 1) %>% stringr::str_to_lower(),
                     stringr::str_sub(string, 2))
  }
  # postprocessing
  if(case == "snake"){
    string <- purrr::map_chr(string, ~ stringr::str_replace_all(.x, "_", postprocess))
  }
  string
}