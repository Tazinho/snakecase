#' caseconverter shortcuts
#'
#' These functions allow you to parse and convert a string to a specific case.
#'
#' @param string A string.
#' @name caseconverter_shortcuts
#' @return A character vector according the specified case.
#' @examples
#' strings <- c("this Is a Strange_string", "AND THIS ANOTHER_One", NA)
#' to_snake_case(strings)
#' to_small_camel_case(strings)
#' to_big_camel_case(strings)
#' to_screaming_snake_case(strings)
#' 
#' @importFrom magrittr "%>%"
NULL

#' @rdname caseconverter_shortcuts
#' @export

to_snake_case2 <- function(string){
  to_parsed_case_internal(string) %>% 
    purrr::map_chr(stringr::str_to_lower)
}

#' @rdname caseconverter_shortcuts
#' @export

to_small_camel_case2 <- function(string){
  out <- to_big_camel_case2(string)
  out <- stringr::str_c(stringr::str_sub(out, 1, 1) %>% stringr::str_to_lower(),
                        stringr::str_sub(out, 2))
  out
}

#' @rdname caseconverter_shortcuts
#' @export

to_big_camel_case2 <- function(string){
  to_parsed_case_internal(string) %>% 
    purrr::map_chr(stringr::str_to_lower) %>% 
    stringr::str_split("_") %>% 
    purrr::map(stringr::str_to_title) %>% 
    purrr::map_chr(stringr::str_c, collapse = "")
}

#' @rdname caseconverter_shortcuts
#' @export 

to_screaming_snake_case2 <- function(string){
  to_parsed_case_internal(string) %>%
    stringr::str_to_upper()
}

#' @rdname caseconverter_shortcuts
#' @export

to_parsed_case2 <- function(string){
  to_parsed_case_internal(string)
}
