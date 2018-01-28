#' Specific case converter shortcuts
#' 
#' Wrappers around \code{to_any_case()}
#'
#' @param string A string (for example names of a data frame).
#'  
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  useful if parsinoption 1 is needed, but some abbreviations need parsing_option 2.
#'  
#' @param sep_in (short for separator input) A regex supplied as a character (if not \code{NULL}), which will be wrapped internally
#' into \code{stringr::regex()}. All matches will be replaced by underscores. Underscores can later turned into another separator via \code{sep_out}.
#' 
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
#' @param transliterations A character vector (if not \code{NULL}). The entries of this argument
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
#' @param sep_out (short for separator output) String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' 
#' @param unique_sep A string. If not \code{NULL}, then duplicated names will get 
#' a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string
#'  to this argument.
#'  
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#'  
#' @param prefix prefix (string).
#' 
#' @param postfix postfix (string).
#' 
#' @return A character vector according the specified parameters above.
#'
#' @note caseconverters are vectorised over \code{string}, \code{sep_in}, \code{sep_out},
#'  \code{empty_fill}, \code{prefix} and \code{postfix}.
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
                          abbreviations = NULL,
                          sep_in = NULL,
                          parsing_option = 1,
                          transliterations = NULL,
                          sep_out = NULL,
                          unique_sep = NULL,
                          empty_fill = NULL,
                          prefix = "",
                          postfix = ""){
  to_any_case(string = string,
              case = "snake",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option, 
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export

to_lower_camel_case <- function(string,
                                abbreviations = NULL,
                                sep_in = NULL,
                                parsing_option = 1,
                                transliterations = NULL, 
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "lower_camel",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option, 
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export

to_upper_camel_case <- function(string,
                                abbreviations = NULL,
                                sep_in = NULL,
                                parsing_option = 1,
                                transliterations = NULL,
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "upper_camel",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option, 
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export 

to_screaming_snake_case <- function(string,
                                    abbreviations = NULL,
                                    sep_in = NULL,
                                    parsing_option = 1,
                                    transliterations = NULL,
                                    sep_out = NULL,
                                    unique_sep = NULL,
                                    empty_fill = NULL,
                                    prefix = "",
                                    postfix = ""){
  to_any_case(string = string,
              case = "screaming_snake",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option, 
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export

to_parsed_case <- function(string,
                           abbreviations = NULL,
                           sep_in = NULL,
                           parsing_option = 1,
                           transliterations = NULL,
                           sep_out = NULL,
                           unique_sep = NULL,
                           empty_fill = NULL,
                           prefix = "",
                           postfix = ""){
  to_any_case(string = string,
              case = "parsed",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option,
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export

to_mixed_case <- function(string,
                          abbreviations = NULL,
                          sep_in = NULL,
                          parsing_option = 1,
                          transliterations = NULL,
                          sep_out = NULL,
                          unique_sep = NULL,
                          empty_fill = NULL,
                          prefix = "",
                          postfix = ""){
  to_any_case(string = string,
              case = "mixed",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option,
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export

to_lower_upper_case <- function(string,
                                abbreviations = NULL,
                                sep_in = NULL,
                                parsing_option = 1,
                                transliterations = NULL,
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "lower_upper",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option,
              abbreviations = abbreviations)
}

#' @rdname caseconverter
#' @export

to_upper_lower_case <- function(string,
                                abbreviations = NULL,
                                sep_in = NULL,
                                parsing_option = 1,
                                transliterations = NULL,
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "upper_lower",
              sep_in = sep_in,
              transliterations = transliterations,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option,
              abbreviations = abbreviations)
}
