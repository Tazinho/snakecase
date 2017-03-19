#' Functions to convert column names to BigCamelCase
#'
#' @param string Character string indicating column names of a data.frame.
#'
#' @return Vector of character strings in BigCamelCase
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case", "_camel_case__")
#' to_big_camel_case(camelCases)
#' to_big_camel_case(names(iris))
#' to_big_camel_case(c(".", "_"))
#' to_big_camel_case(NA)
#' to_big_camel_case(NULL)
#' to_big_camel_case(character(0))
#' to_big_camel_case("   N A")
#'
#' @importFrom magrittr "%>%"
#'
#' @export
#'
to_big_camel_case <- function(string){
  to_snake_case_internal(string) %>% 
    stringr::str_split("_") %>% 
    purrr::map(stringr::str_to_title) %>% 
    purrr::map_chr(stringr::str_c, collapse = "")
}