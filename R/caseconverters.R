#' Specific case converter shortcuts
#' 
#' These functions allow you to parse and convert a string to a specific case.
#'
#' @param string A string.
#' @name caseconverter
#' @return A character vector according the specified target case.
#' 
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#' 
#' @examples
#' strings <- c("this Is a Strange_string", "AND THIS ANOTHER_One", NA)
#' 
#' to_snake_case(strings)
#' to_small_camel_case(strings)
#' to_big_camel_case(strings)
#' to_screaming_snake_case(strings)
#' to_parsed_case(strings)
#' 
#' @importFrom magrittr "%>%"
NULL

#' @rdname caseconverter
#' @seealso \code{\link{to_any_case}} for flexible high level conversion with a lot of additional functionality.
#' @export

to_snake_case <- function(string){
  to_parsed_case_internal(string) %>% 
    purrr::map_chr(stringr::str_to_lower)
}

#' @rdname caseconverter
#' @export

to_small_camel_case <- function(string){
  out <- to_big_camel_case(string)
  out <- stringr::str_c(stringr::str_sub(out, 1, 1) %>% stringr::str_to_lower(),
                        stringr::str_sub(out, 2))
  out
}

#' @rdname caseconverter
#' @export

to_big_camel_case <- function(string){
  to_parsed_case_internal(string) %>% 
    purrr::map_chr(stringr::str_to_lower) %>% 
    stringr::str_split("_") %>% 
    purrr::map(stringr::str_to_title) %>% 
    purrr::map_chr(stringr::str_c, collapse = "")
}

#' @rdname caseconverter
#' @export 

to_screaming_snake_case <- function(string){
  to_parsed_case_internal(string) %>%
    stringr::str_to_upper()
}

#' @rdname caseconverter
#' @export

to_parsed_case <- function(string){
  to_parsed_case_internal(string)
}
