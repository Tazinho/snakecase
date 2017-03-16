#' Functions to convert column names to snake_case
#'
#' @param camelcases Character string indicating column names of a data.frame.
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
to_snake_case <- function(camelcases){
  # catch some input that should be handled like underscores too
  camelcases <- stringr::str_replace_all(camelcases, "\\s+|\\.+", "_")
  # Changes behaviour of the function. Cases like RStudio will be converted
  # to r_studio and not to rstudio anymore
  camelcases <- stringr::str_replace_all(camelcases, "([A-Z][a-z]+)", "_\\1_")
  # get to know, if a string starts with a small letter
  small_start <- !is.na(stringr::str_extract(camelcases, "^[a-z]"))
  # get all capital letter sequences from a string
  capitals <- stringr::str_extract_all(camelcases, "[A-Z]+")
  # Setting an underscore before capital and first letters
  starts <- purrr::pmap(list(camelcases,
                             small_start,
                             capitals),
                        function(x,y,z)
                          if (length(z) == 0) {"_"} else {
                            c("_", paste0("_", z))
                          }
  )
  # split the strings by their capital letter sequences.
  rests <- stringr::str_split(camelcases, "[A-Z]+")
  # setting all peaces together:
  # - pasting first and capital letters with the rest of the string
  # - applying tolower, remove more than one "_" and starting "_"
  corrected <- purrr::map2_chr(starts, rests, stringr::str_c, collapse = "") %>% 
    purrr::map_chr(stringr::str_to_lower) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_+|_+$", ""))
  corrected
}

#' Functions to convert column names to snake_case
#'
#' @param camelcases Character string indicating column names of a data.frame.
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
to_snake_case_dev2 <- function(camelcases){
  # catch some input that should be handled like underscores too
  camelcases <- stringr::str_replace_all(camelcases, "\\s+|\\.+", "_")
  # Changes behaviour of the function. Cases like RStudio will be converted
  # to r_studio and not to rstudio anymore
  camelcases <- stringr::str_replace_all(camelcases, "([A-Z][a-z]+)", "_\\1_")
  # get to know, if a string starts with a small letter
  small_start <- !is.na(stringr::str_extract(camelcases, "^[a-z]"))
  # get all capital letter sequences from a string
  capitals <- stringr::str_extract_all(camelcases, "[A-Z]+")
  # Setting an underscore before capital and first letters
  starts <- purrr::pmap(list(camelcases,
                             small_start,
                             capitals),
                        function(x,y,z)
                          if (length(z) == 0) {"_"} else {
                            c("_", paste0("_", z))
                          }
  )
  # split the strings by their capital letter sequences.
  rests <- stringr::str_split(camelcases, "[A-Z]+")
  # setting all peaces together:
  # - pasting first and capital letters with the rest of the string
  # - applying tolower, remove more than one "_" and starting "_"
  corrected <- purrr::map2_chr(starts, rests, stringr::str_c, collapse = "") %>% 
    purrr::map_chr(stringr::str_to_lower) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "_+", "_")) %>% 
    purrr::map_chr(~ stringr::str_replace_all(.x, "^_+|_+$", ""))
  corrected
}