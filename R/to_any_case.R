#' General case conversion
#' 
#' Function to convert strings to any case
#'
#' @param string A string (for example names of a data frame).
#' @param case The desired target case, provided as one of \code{"snake"}, \code{"small_camel"}, \code{"big_camel"}, 
#' \code{"screaming_snake"} or \code{"parsed"}. The latter one is not really a case, but is helpful since it
#' returns the parsed input string, separated by underscores, without any further modification.
#' @param preprocess String that will be wrapped internally into \code{stringr::regex()}. 
#' All matches will be treated as additional splitting parameters besides the default ones 
#' (\code{"_"} and \code{" "}), when parsing the input string.
#' @param protect A string which is a valid \code{stringr::regex()}. Matches within the output
#' won't have any "_" (or artifacts of \code{preprocess}) beside. Note that \code{preprocess} has a higher precedence than protect, 
#' which means that it doesn't make sense to protect sth. which is already replaced
#' via \code{preprocess}.
#' @param replace_special_characters Logical, if \code{TRUE}, special characters 
#' will be translated to characters which are more likely to be understood by 
#' different programs. For example german umlauts will be translated to ae, oe, ue etc.
#' @param postprocess String that will be used as separator. The defaults are \code{"_"} 
#' and \code{""}, regarding the specified \code{case}.
#' @param prefix prefix (string).
#' @param postfix postfix (string).
#' @param empty_fill A string. If it is supplied, then each entry that matches "" will be replaced
#' by the supplied string to this argument.
#' @param unique_sep A string. If it is supplied, then duplicated names will get a suffix integer
#' in the order of their appearance. The suffix is separated by the supplied string to this argument.
#' @param parsingoption An integer (1 (default), 2 or 3) that will determine the parsingoption.
#' 1: RRRStudio -> RRR_Studio
#' 2: RRRStudio -> RRRS_tudio
#' If another integer is supplied, no parsing regarding the pattern of upper- and lowercase will appear.
#' 
#' @return A character vector according the specified parameters above.
#'
#' @note \code{to_any_case()} is vectorised over \code{postprocess}, \code{prefix} and \code{postfix}.
#' \code{postprocess} might follow in the future.
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' ### Default usage
#' strings <- c("this Is a Strange_string", "AND THIS ANOTHER_One")
#' to_any_case(strings, case = "snake")
#' to_any_case(strings, case = "small_camel")
#' to_any_case(strings, case = "big_camel")
#' to_any_case(strings, case = "screaming_snake")
#' to_any_case(strings, case = "parsed")
#' 
#' ### Pre -and postprocessing
#' strings2 <- c("this - Is_-: a Strange_string", "AND THIS ANOTHER_One")
#' to_snake_case(strings2)
#' to_any_case(strings2, case = "snake", preprocess = "-|\\:")
#' 
#' to_any_case(strings2, case = "snake", preprocess = "-|\\:", postprocess = " ")
#' to_any_case(strings2, case = "big_camel", preprocess = "-|\\:", postprocess = "//")
#' 
#' ### Pre -and postfix
#' to_any_case(strings2, case = "big_camel", preprocess = "-|\\:", postprocess = "//",
#'             prefix = "USER://", postfix = ".exe")
#' 
#' ### Special characters like german umlauts for example can be replaced via 
#' # replace_special_characters = TRUE
#' 
#' ### Protect anything that shouldn't have an underscore beside in the output
#' strings3 <- c("var12", "var1.2", "va.r.1.2")
#' to_any_case(strings3, case = "snake")
#' to_any_case(strings3, case = "snake", protect = "\\d")
#' to_any_case(strings3, case = "snake", protect = "\\d|\\.")
#' 
#' @importFrom magrittr "%>%"
#'
#' @seealso \href{https://github.com/Tazinho/snakecase}{snakecase on github} or 
#' \code{\link{caseconverter}} for some handy shortcuts.
#'
#' @export
#'
to_any_case <- function(string, case = c("snake", "small_camel", "big_camel", "screaming_snake", "parsed"), preprocess = NULL, protect = NULL, replace_special_characters = FALSE, postprocess = NULL, prefix = "", postfix = "", unique_sep = NULL, empty_fill = NULL, parsingoption = 1){
  case <- match.arg(case)
  
  ### preprocess and parsing
  string <- to_parsed_case_internal(string, preprocess = preprocess, parsingoption = parsingoption)
  
  ### protect (must come after caseconversion, but before postprocess, because the 
  # separator has to be "_" or a default string, 
  # but must not be a reg exp, which would have to be used otherwise)
  if(!case %in% c("small_camel", "big_camel")){
    if(!is.null(protect)){
      string <- protect_internal(string, protect)
    }
  }
  
  ### replace Special Characters (must come after split from the cases, but before the caseconversion)
  if(replace_special_characters){
    string <- string %>%
      purrr::map_chr(
        ~ stringr::str_replace_all(.x, c("\u00C4" = "Ae",
                                         "\u00D6" = "Oe",
                                         "\u00DC" = "Ue",
                                         "\u00E4" = "ae",
                                         "\u00F6" = "oe",
                                         "\u00FC" = "ue",
                                         "\u00DF" = "ss",
                                         "\u0025" = "_percent_",
                                         "\\`" = "",
                                         "\\'" = "",
                                         "\\@" = "_at_")
                                   )
        )
  }
  
  ### cases and postprocessing
  
  # parsedcase with postprocessing 
  if(case == "parsed" & !is.null(postprocess)){
    string <- purrr::map2_chr(string,
                              postprocess,
                              ~ stringr::str_replace_all(.x, "_", .y))}
  
  ## other cases without postprocessing
  if(case %in% c("snake", "small_camel", "big_camel", "screaming_snake")){
    string <- string %>% purrr::map_chr(stringr::str_to_lower)
  }
  
  ## postprocessing and further conversion for other cases
  # caseconversion to small-/big camel case
  if(case == "small_camel" | case == "big_camel"){
    string <- string %>% 
      stringr::str_split(pattern = "(?<!\\d)_|_(?!\\d)") %>% 
      purrr::map(stringr::str_to_title)
    if(is.null(postprocess)){
      string <- string %>% purrr::map_chr(stringr::str_c, collapse = "")
    } else {
      string <- string %>% purrr::map_chr(stringr::str_c, collapse = "_")
      string <- purrr::map2_chr(string, postprocess, ~ stringr::str_replace_all(.x, "_", .y))  
    }
  }
  if(case == "small_camel"){
    string <- stringr::str_c(stringr::str_sub(string, 1, 1) %>%
                               stringr::str_to_lower(),
                             stringr::str_sub(string, 2))
  }
  # snake- and screaming_snake
  if(case == "snake" | case == "screaming_snake"){
    if(is.null(postprocess)){
      string <- purrr::map_chr(string,
                               ~ stringr::str_replace_all(.x, "_", "_"))
    } else {
      string <- purrr::map2_chr(string, 
                                postprocess, ~ stringr::str_replace_all(.x, "_", .y))
    }
  }
  
  ## screaming_snake
  if(case == "screaming_snake"){
    string <- string %>% stringr::str_to_upper()
  }
  
  ## pre and postfix
  string <- stringr::str_c(prefix, string, postfix)
  ## fill empty strings
  if(!is.null(empty_fill))
  string[string == ""] <- empty_fill
  ## make unique
  if(!is.null(unique_sep))
  string <- make.unique(string, sep = unique_sep)
  ## return
  string
}
