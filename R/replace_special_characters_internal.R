#' Internal helper to replace special characters.
#'
#' @param string A string (for example names of a data frame).
#' @param transliterations A character vector (if not \code{NULL}). The entries of this argument
#' need to be elements of \code{stringi::stri_trans_list()} (like "Latin-ASCII", which is often useful) or names of lookup tables (currently
#' only "german" is supported). In the order of the entries the letters of the input
#'  string will be transliterated via \code{stringi::stri_trans_general()} or replaced via the 
#'  matches of the lookup table.
#' 
#' @param case Length one character, from the input options of \code{to_any_case}.
#' 
#' @return A character vector.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
replace_special_characters_internal <- function(string, transliterations, case){
  dictionary <- list(
    german = c("\u00C4" = "Ae", "\u00D6" = "Oe", "\u00DC" = "Ue",
               "\u00E4" = "ae", "\u00F6" = "oe", "\u00FC" = "ue",
               "\u00DF" = "ss"),
    danish = c("\u00C6" = "Ae",
               "\u00E6" = "ae",
               "\u00D8" = "Oe",
               "\u00F8" = "oe",
               "\u00C5" = "Aa",
               "\u00E5" = "aa")
    )
  for (i in seq_along(transliterations)){
    if(transliterations[i] %in% stringi::stri_trans_list()){
      string <- stringi::stri_trans_general(string, transliterations[i])
      } else if(transliterations[i] %in% names(dictionary)){
        string <- stringr::str_replace_all(string, dictionary[[transliterations[i]]]) 
      } else {
          stop("Input to `transliterations` must be `NULL` or a string containing elements
               from the internal lookup dictionaries or from `stringi::stri_trans_list()`.",
                  call. = FALSE)
      }
  }
  # "\u0025" = "_percent_",
    # "\\`" = "",
    # "\\'" = "",
    # "\\@" = "_at_")
  string
}