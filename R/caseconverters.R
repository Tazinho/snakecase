#' Specific case converter shortcuts
#' 
#' These functions allow you to parse and convert a string to a specific case.
#'
#' @param string A string (for example names of a data frame).
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
#' to_lower_upper_case(strings)
#' to_upper_lower_case(strings)
#' to_parsed_case(strings)
#' to_mixed_case(strings)
#' 
#' 
#' @importFrom magrittr "%>%"
NULL

#' @rdname caseconverter
#' @seealso \href{https://github.com/Tazinho/snakecase}{snakecase on github}, \code{\link{to_any_case}} for flexible high level conversion.
#' @export

to_snake_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  string <- to_parsed_case_internal(string) %>% 
    purrr::map_chr(stringr::str_to_lower)
  # Protect (only internal, not via an argument).
  # Replace all "_" by "" which are around a not alphanumeric character
  string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  names(string) <- string_names
  string
}

#' @rdname caseconverter
#' @export

to_small_camel_case <- function(string){
  # save names-attribute
  out_names <- names(string)
  out <- to_big_camel_case(string)
  out <- stringr::str_c(stringr::str_sub(out, 1, 1) %>% stringr::str_to_lower(),
                        stringr::str_sub(out, 2))
  names(out) <- out_names
  out
}

#' @rdname caseconverter
#' @export

to_big_camel_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  string <- to_parsed_case_internal(string) %>% 
    purrr::map_chr(stringr::str_to_lower) %>% 
    stringr::str_split("(?<!\\d)_|_(?!\\d)") %>% 
    purrr::map(stringr::str_to_title) %>% 
    purrr::map_chr(stringr::str_c, collapse = "")
  names(string) <- string_names
  string
}

#' @rdname caseconverter
#' @export 

to_screaming_snake_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  string <- to_parsed_case_internal(string) %>%
    stringr::str_to_upper()
  # Protect (only internal, not via an argument).
  # Replace all "_" by "" which are around a not alphanumeric character
  string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  names(string) <- string_names
  string
}

#' @rdname caseconverter
#' @export

to_parsed_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  string <- to_parsed_case_internal(string)
  # Protect (only internal, not via an argument).
  # Replace all "_" by "" which are around a not alphanumeric character
  string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  names(string) <- string_names
  string
}

#' @rdname caseconverter
#' @export

to_mixed_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  string <- to_parsed_case_internal(string)
  string <- string %>% stringr::str_split("_")
  string <- string %>% 
    purrr::map(~stringr::str_c(stringr::str_sub(.x, 1, 1),
                               stringr::str_sub(.x, 2) %>%
                                 stringr::str_to_lower()))
  string <- string %>% purrr::map_chr(~stringr::str_c(.x, collapse = "_"))
  # Protect (only internal, not via an argument).
  # Replace all "_" by "" which are around a not alphanumeric character
  string <- stringr::str_replace_all(string, "_(?![:alnum:])|(?<![:alnum:])_", "")
  names(string) <- string_names
  string
}

#' @rdname caseconverter
#' @export

to_lower_upper_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  string <- to_parsed_case_internal(string)
  string <- string %>% stringr::str_split("_")
  
  relevant <- function(string){
    relevant <- string %>% stringr::str_detect("[:alpha:]")
    relevant[relevant] <- rep_len(c(TRUE, FALSE), sum(relevant))
    relevant
  }
  
  string[!is.na(string)] <- purrr::map2(string[!is.na(string)],
                                        purrr::map(string[!is.na(string)],
                                                   ~ relevant(.x)),
                        # odds to lower
                        ~{.x[.y] <- stringr::str_to_lower(.x[.y]);
                        # others to upper
                        .x[!.y] <- stringr::str_to_upper(.x[!.y]);
                        .x}) 
  string <- string %>% purrr::map_chr(stringr::str_c, collapse = "")
  names(string) <- string_names
  string
}

#' @rdname caseconverter
#' @export

to_upper_lower_case <- function(string){
  # save names-attribute
  string_names <- names(string)
  
  string <- to_parsed_case_internal(string)
  string <- string %>% stringr::str_split("_")
  
  relevant <- function(string){
    relevant <- string %>% stringr::str_detect("[:alpha:]")
    relevant[relevant] <- rep_len(c(TRUE, FALSE), sum(relevant))
    relevant
  }
  
  string[!is.na(string)] <- purrr::map2(string[!is.na(string)],
                                        purrr::map(string[!is.na(string)],
                                                   ~ relevant(.x)),
                        # odds to upper
                        ~{.x[.y] <- stringr::str_to_upper(.x[.y]);
                        # others to lower
                        .x[!.y] <- stringr::str_to_lower(.x[!.y]);
                        .x}) 
  string <- string %>% purrr::map_chr(stringr::str_c, collapse = "")
  names(string) <- string_names
  string
}
