#' Specific case converter shortcuts
#' 
#' Wrappers around \code{to_any_case()}
#'
#' @param string A string (for example names of a data frame).
#'  
#' @param abbreviations character with (uppercase) abbreviations. This marks
#'  abbreviations with an underscore behind (in front of the parsing).
#'  Useful if \code{parsing_option} 1 is needed, but some abbreviations within the string need \code{parsing_option} 2.
#'  Use this feature with care: One letter abbreviations and abbreviations next to each other may not be handled correctly, since those cases would introduce ambiguity in parsing.
#'  
#' @param sep_in (short for separator input) if character, is interpreted as a
#'  regular expression (wrapped internally into \code{stringr::regex()}). 
#'  The default value is a regular expression that matches any sequence of
#'  non-alphanumeric values. All matches will be replaced by underscores 
#'  (additionally to \code{"_"} and \code{" "}, for which this is always true, even
#'  if \code{NULL} is supplied). These underscores are used internally to split
#'  the strings into substrings and specify the word boundaries.
#' 
#' @param parsing_option An integer that will determine the parsing_option.
#' \itemize{
#'  \item{1: \code{RRRStudio -> RRR_Studio}}
#'  \item{2: \code{RRRStudio -> RRRS_tudio}}
#'  \item{3: This \code{parsing_option} will suppress the conversion after non-alphanumeric
#'  values. See examples.}
#'  \item{4: digits directly behind/in front non-digits, will stay as is.}
#'  \item{any other integer <= 0: no parsing"}
#'  }
#' 
#' @param transliterations A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} (like "Latin-ASCII", which is often useful) or names of lookup tables (currently
#' only "german" is supported). In the order of the entries the letters of the input
#'  string will be transliterated via \code{stringi::stri_trans_general()} or replaced via the 
#'  matches of the lookup table. When named character elements are supplied as part of `transliterations`, anything that matches the names is replaced by the corresponding value.

#' You should use this feature with care in case of \code{case = "parsed"}, \code{case = "internal_parsing"} and 
#' \code{case = "none"}, since for upper case letters, which have transliterations/replacements
#'  of length 2, the second letter will be transliterated to lowercase, for example Oe, Ae, Ss, which
#'  might not always be what is intended. In this case you can make usage of the option to supply named elements and specify the transliterations yourself.
#' 
#' @param numerals A character specifying the alignment of numerals (\code{"middle"}, \code{left}, \code{right} or \code{asis}). I.e. \code{numerals = "left"} ensures that no output separator is in front of a digit.
#' 
#' @param sep_out (short for separator output) String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}. When \code{length(sep_out) > 1}, the last element of \code{sep_out} gets recycled and separators are incorporated per string according to their order.
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
#' to_swap_case(strings)
#' to_sentence_case(strings)
#' to_random_case(strings)
#' to_title_case(strings)
#' 
#' 
#' @rdname caseconverter
#' @seealso \href{https://github.com/Tazinho/snakecase}{snakecase on github}, \code{\link{to_any_case}} for flexible high level conversion and more examples.
#' @export

to_snake_case <- function(string,
                          abbreviations = NULL,
                          sep_in = "[^[:alnum:]]",
                          parsing_option = 1,
                          transliterations = NULL,
                          numerals = "middle",
                          sep_out = NULL,
                          unique_sep = NULL,
                          empty_fill = NULL,
                          prefix = "",
                          postfix = ""){
  to_any_case(string = string,
              case = "snake",
              sep_in = sep_in,
              transliterations = transliterations,     
              numerals = numerals,
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
                                sep_in = "[^[:alnum:]]",
                                parsing_option = 1,
                                transliterations = NULL,   
                                numerals = "middle", 
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "lower_camel",
              sep_in = sep_in,
              transliterations = transliterations,               
              numerals = numerals,
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
                                sep_in = "[^[:alnum:]]",
                                parsing_option = 1,
                                transliterations = NULL,                           
                                numerals = "middle",                                  
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "upper_camel",
              sep_in = sep_in,
              transliterations = transliterations,               
              numerals = numerals,
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
                                    sep_in = "[^[:alnum:]]",
                                    parsing_option = 1,
                                    transliterations = NULL,                      
                                    numerals = "middle",                                  
                                    sep_out = NULL,
                                    unique_sep = NULL,
                                    empty_fill = NULL,
                                    prefix = "",
                                    postfix = ""){
  to_any_case(string = string,
              case = "screaming_snake",
              sep_in = sep_in,
              transliterations = transliterations,               
              numerals = numerals,
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
                           sep_in = "[^[:alnum:]]",
                           parsing_option = 1,
                           transliterations = NULL,                     
                           numerals = "middle",                                  
                           sep_out = NULL,
                           unique_sep = NULL,
                           empty_fill = NULL,
                           prefix = "",
                           postfix = ""){
  to_any_case(string = string,
              case = "parsed",
              sep_in = sep_in,
              transliterations = transliterations,               
              numerals = numerals,
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
                          sep_in = "[^[:alnum:]]",
                          parsing_option = 1,
                          transliterations = NULL,               
                          numerals = "middle",   
                          sep_out = NULL,
                          unique_sep = NULL,
                          empty_fill = NULL,
                          prefix = "",
                          postfix = ""){
  to_any_case(string = string,
              case = "mixed",
              sep_in = sep_in,
              transliterations = transliterations,               
              numerals = numerals,
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
                                sep_in = "[^[:alnum:]]",
                                parsing_option = 1,
                                transliterations = NULL,        
                                numerals = "middle",   
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "lower_upper",
              sep_in = sep_in,
              transliterations = transliterations,  
              numerals = numerals,
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
                                sep_in = "[^[:alnum:]]",
                                parsing_option = 1,
                                transliterations = NULL,  
                                numerals = "middle",  
                                sep_out = NULL,
                                unique_sep = NULL,
                                empty_fill = NULL,
                                prefix = "",
                                postfix = ""){
  to_any_case(string = string,
              case = "upper_lower",
              sep_in = sep_in,
              transliterations = transliterations,            
              numerals = numerals,
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

to_swap_case <- function(string,
                         abbreviations = NULL,
                         sep_in = "[^[:alnum:]]",
                         parsing_option = 1,
                         transliterations = NULL,             
                         numerals = "middle",                   
                         sep_out = NULL,
                         unique_sep = NULL,
                         empty_fill = NULL,
                         prefix = "",
                         postfix = ""){
  to_any_case(string = string,
              case = "swap",
              sep_in = sep_in,
              transliterations = transliterations,              
              numerals = numerals,
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

to_sentence_case <- function(string,
                         abbreviations = NULL,
                         sep_in = "[^[:alnum:]]",
                         parsing_option = 1,
                         transliterations = NULL,       
                         numerals = "middle",                     
                         sep_out = NULL,
                         unique_sep = NULL,
                         empty_fill = NULL,
                         prefix = "",
                         postfix = ""){
  to_any_case(string = string,
              case = "sentence",
              sep_in = sep_in,
              transliterations = transliterations,  
              numerals = numerals,
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

to_random_case <- function(string,
                         abbreviations = NULL,
                         sep_in = "[^[:alnum:]]",
                         parsing_option = 1,
                         transliterations = NULL,             
                         numerals = "middle",                   
                         sep_out = NULL,
                         unique_sep = NULL,
                         empty_fill = NULL,
                         prefix = "",
                         postfix = ""){
  to_any_case(string = string,
              case = "random",
              sep_in = sep_in,
              transliterations = transliterations,              
              numerals = numerals,
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

to_title_case <- function(string,
                         abbreviations = NULL,
                         sep_in = "[^[:alnum:]]",
                         parsing_option = 1,
                         transliterations = NULL,             
                         numerals = "middle",                   
                         sep_out = NULL,
                         unique_sep = NULL,
                         empty_fill = NULL,
                         prefix = "",
                         postfix = ""){
  to_any_case(string = string,
              case = "title",
              sep_in = sep_in,
              transliterations = transliterations,              
              numerals = numerals,
              sep_out = sep_out,
              prefix = prefix,
              postfix = postfix,
              unique_sep = unique_sep,
              empty_fill = empty_fill,
              parsing_option = parsing_option,
              abbreviations = abbreviations)
}
