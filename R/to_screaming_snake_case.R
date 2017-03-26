#' Functions to convert column names to snake_case
#'
#' @param string Character string indicating column names of a data.frame.
#'
#' @return Vector of character strings in SCREAMING_SNAKE_CASE
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
to_screaming_snake_case <- function(string){
  to_parsed_case_internal(string) %>%
    stringr::str_to_upper()
}