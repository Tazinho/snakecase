#' Functions to convert column names to smallCamelCase
#'
#' @param string Character string indicating column names of a data.frame.
#'
#' @return Vector of character strings in smallCamelCase
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case", "_camel_case__")
#' to_small_camel_case(camelCases)
#' to_small_camel_case(names(iris))
#' to_small_camel_case(c(".", "_"))
#' to_small_camel_case(NA)
#' to_small_camel_case(NULL)
#' to_small_camel_case(character(0))
#' to_small_camel_case("   N A")
#'
#' @importFrom magrittr "%>%"
#'
#' @export
#'
to_small_camel_case <- function(string){
  out <- to_big_camel_case(string)
  out <- stringr::str_c(stringr::str_sub(out, 1, 1) %>% stringr::str_to_lower(),
                        stringr::str_sub(out, 2))
  out
}