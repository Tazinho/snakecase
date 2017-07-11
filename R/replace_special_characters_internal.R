#' Internal helper to replace special characters.
#'
#' @param string A string (for example names of a data frame).
#' @param replace_special_characters Logical, if \code{TRUE}, special characters 
#' will be translated to characters which are more likely to be understood by 
#' different programs. For example german umlauts will be translated to ae, oe, ue etc.
#' @param case Length one character, from the imput options of \code{to_any_case}.
#' 
#' @return A character vector.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
replace_special_characters_internal <- function(string, replace_special_characters, case){
  dictionary <- list(
    german = c("\u00C4" = "Ae", "\u00D6" = "Oe", "\u00DC" = "Ue",
               "\u00E4" = "ae", "\u00F6" = "oe", "\u00FC" = "ue",
               "\u00DF" = "ss")
    )
  for (i in seq_along(replace_special_characters)){
    if(replace_special_characters[i] %in% stringi::stri_trans_list()){
      string <- stringi::stri_trans_general(string, replace_special_characters[i])
      } else if(replace_special_characters[i] %in% names(dictionary)){
        string <- stringr::str_replace_all(string, dictionary[[replace_special_characters[i]]]) 
      }
    }
  # "\u0025" = "_percent_",
    # "\\`" = "",
    # "\\'" = "",
    # "\\@" = "_at_")
  string
  }