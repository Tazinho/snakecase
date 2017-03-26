#' Functions to convert column names to snake_case
#'
#' @inheritParams to_parsed_case_internal
#'
#' @return Vector of character strings, parsed for conversion to snake_case, separated by "_"
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case", "_camel_case__")
#' to_parsed_case(camelCases)
#' to_parsed_case(names(iris))
#' to_parsed_case(c(".", "_"))
#' to_parsed_case(NA)
#' to_parsed_case(NULL)
#' to_parsed_case(character(0))
#' to_parsed_case("   N A")
#'
#' @importFrom magrittr "%>%"
#'
#' @export
#'
to_parsed_case <- function(string){
  to_parsed_case_internal(string)
}
