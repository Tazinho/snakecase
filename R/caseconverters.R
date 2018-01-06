#' Specific case converter shortcuts
#' 
#' Wrappers around \code{to_any_case()}
#'
#' @param string A string (for example names of a data frame).
#'  
#' @param preprocess A string (if not \code{NULL}) that will be wrapped internally
#' into \code{stringr::regex()}. All matches will be replaced by underscores. Underscores can later turned into another separator via \code{postprocess}.
#' 
#' @param replace_special_characters A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} (like "Latin-ASCII", which is often useful) or names of lookup tables (currently
#' only "german" is supported). In the order of the entries the letters of the input
#'  string will be transliterated via \code{stringi::stri_trans_general()} or replaced via the 
#'  matches of the lookup table.
#' 
#' You should use this feature with care in case of \code{case = "parsed"} and 
#' \code{case = "none"}, since for upper case letters, which have transliterations/replacements
#'  of length 2, the second letter will be transliterated to lowercase, for example Oe, Ae, Ss, which
#'  might not always be what is intended.
#' 
#' @param postprocess String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' @param prefix prefix (string).
#' @param postfix postfix (string).
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#' @param unique_sep A string. If not \code{NULL}, then duplicated names will get 
#' a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string
#'  to this argument.
#' @param parsing_option An integer that will determine the parsing_option.
#' #' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: parses at the beginning like option 1 and the rest like option 2.}
#'  \item{4: parses at the beginning like option 2 and the rest like option 1.}
#'  \item{5: parses like option 1 but suppresses "_" around non special characters.
#'  In this way case conversion won't apply after these characters. See examples.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#'  
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  useful if parsinoption 1 is needed, but some abbreviations need parsing_option 2.
#' 
#' @return A character vector according the specified parameters above.
#'
#' @note caseconverters are vectorised over \code{postprocess}, \code{prefix} and \code{postfix}.
#' \code{postprocess} might follow in the future.
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#' 
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
#' to_lower_camel_case(strings)
#' to_upper_camel_case(strings)
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

to_snake_case <- function(string,
                          preprocess = NULL,
                          replace_special_characters = NULL,
                          postprocess = NULL,
                          prefix = "",
                          postfix = "",
                          unique_sep = NULL,
                          empty_fill = NULL,
                          parsing_option = 1,
                          abbreviations = NULL){
  to_any_case(string,
              case = "snake",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export

to_lower_camel_case <- function(string,
                                preprocess = NULL,
                                replace_special_characters = NULL,
                                postprocess = NULL,
                                prefix = "",
                                postfix = "",
                                unique_sep = NULL,
                                empty_fill = NULL,
                                parsing_option = 1,
                                abbreviations = NULL){
  to_any_case(string,
              case = "lower_camel",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export

to_upper_camel_case <- function(string,
                              preprocess = NULL,
                              replace_special_characters = NULL,
                              postprocess = NULL,
                              prefix = "",
                              postfix = "",
                              unique_sep = NULL,
                              empty_fill = NULL,
                              parsing_option = 1,
                              abbreviations = NULL){
  to_any_case(string,
              case = "upper_camel",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export 

to_screaming_snake_case <- function(string,
                                    preprocess = NULL,
                                    replace_special_characters = NULL,
                                    postprocess = NULL,
                                    prefix = "",
                                    postfix = "",
                                    unique_sep = NULL,
                                    empty_fill = NULL,
                                    parsing_option = 1,
                                    abbreviations = NULL){
  to_any_case(string,
              case = "screaming_snake",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export

to_parsed_case <- function(string,
                           preprocess = NULL,
                           replace_special_characters = NULL,
                           postprocess = NULL,
                           prefix = "",
                           postfix = "",
                           unique_sep = NULL,
                           empty_fill = NULL,
                           parsing_option = 1,
                           abbreviations = NULL){
  to_any_case(string,
              case = "parsed",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export

to_mixed_case <- function(string,
                          preprocess = NULL,
                          replace_special_characters = NULL,
                          postprocess = NULL,
                          prefix = "",
                          postfix = "",
                          unique_sep = NULL,
                          empty_fill = NULL,
                          parsing_option = 1,
                          abbreviations = NULL){
  to_any_case(string,
              case = "mixed",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export

to_lower_upper_case <- function(string,
                                preprocess = NULL,
                                replace_special_characters = NULL,
                                postprocess = NULL,
                                prefix = "",
                                postfix = "",
                                unique_sep = NULL,
                                empty_fill = NULL,
                                parsing_option = 1,
                                abbreviations = NULL){
  to_any_case(string,
              case = "lower_upper",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}

#' @rdname caseconverter
#' @export

to_upper_lower_case <- function(string,
                                preprocess = NULL,
                                replace_special_characters = NULL,
                                postprocess = NULL,
                                prefix = "",
                                postfix = "",
                                unique_sep = NULL,
                                empty_fill = NULL,
                                parsing_option = 1,
                                abbreviations = NULL){
  to_any_case(string,
              case = "upper_lower",
              preprocess = NULL,
              protect = "_(?![:alnum:])|(?<![:alnum:])_",
              replace_special_characters = NULL,
              postprocess = NULL,
              prefix = "",
              postfix = "",
              unique_sep = NULL,
              empty_fill = NULL,
              parsing_option = 1,
              abbreviations = NULL)
}
