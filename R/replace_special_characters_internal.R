#' Internal helper to replace special characters.
#'
#' @param string A string (for example names of a data frame).
#' 
#' @return A character vector.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
replace_special_characters_internal <- function(string, replace_special_characters){
  if (replace_special_characters){
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
    string
  }
  
  string
}