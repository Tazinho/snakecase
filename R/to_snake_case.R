#' Functions to convert column names to snake_case
#'
#' @param string Character string indicating column names of a data.frame.
#'
#' @return Vector of character strings in snake_case
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case", "_camel_case__")
#' to_snake_case(camelCases)
#' to_snake_case(names(iris))
#' to_snake_case(c(".", "_"))
#' to_snake_case(NA)
#' to_snake_case(NULL)
#' to_snake_case(character(0))
#' to_snake_case("   N A")
#'
#' @importFrom magrittr "%>%"
#'
#' @export
#'
to_snake_case <- function(string){
  # catch some input that should be handled like underscores too (only spaces!)
  string <- stringr::str_replace_all(string, "\\s+", "_")
  # Changes behaviour of the function. Cases like RStudio will be converted
  # to r_studio and not to rstudio anymore. Inserts underscores around groups
  # of big letters with following small letters
  string <- stringr::str_replace_all(string, "([A-ZÄÖÜ][a-z\xffffffe4öüß]+)", "_\\1_")
  # Inserts underscores around all capital letter groups with length >= 2
  string <- stringr::str_replace_all(string, "([A-ZÄÖÜ]{2,})", "_\\1_")
  # Inserts underscores around all capital letter groups with length = 1 that
  # don't have a capital letter in front of them and a capital or small letter behind them
  string <- stringr::str_replace_all(string, "([A-ZÄÖÜ]*[A-ZÄÖÜ]{1}[A-ZÄÖÜa-z\xffffffe4öüß]*)", "_\\1_")
  # customize the output to snake case
  # - applying tolower, remove more than one "_" and starting/ending "_"
  string <- string %>% purrr::map_chr(stringr::str_to_lower) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_|_$", ""))
  string
}
