#' Functions to convert column names to snake_case
#'
#' @param string Character string indicating column names of a data.frame.
#' @param case Character string ("snake", "small_camel", "big_camel" or "screaming_snake"), indicating 
#' case should be the target case, that the string should be converted into.
#' @param preprocess Character string that will be wrapped internally into stringr::regex. All matches will be
#' treated like underscore. This is useful and gives flexibility to customize conversion
#' of strings that contain also dots, hyphens and/or other special characters.
#' @param postprocess Character string that will be the separator between different words. When `case == "snake"`
#' it will replace the underscore.
#' @param prefix prefix
#' @param postfix postfix
#' @param replace_special_characters if `TRUE`, special characters will be translated to characters which are more likely to be understood by different programs. For example german umlauts will be translated to ae, oe, ue etc.
#'
#' @return character
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
#' @examples
#' camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case", "_camel_case__")
#' to_any_case(camelCases, case = "snake")
#' to_any_case("fsdf.d-sf", case = "snake", preprocess = "\\.|-")
#'
#' @importFrom magrittr "%>%"
#'
#' @export
#'
to_any_case <- function(string, case = c("snake", "small_camel", "big_camel", "screaming_snake"), preprocess = NULL, postprocess = NULL, prefix = "", postfix = "", replace_special_characters = FALSE){
  string <- to_snake_case_internal(string, preprocess = preprocess)
  ## postprocessing
  # caseconversion to small-/big camel case
  if(case == "small_camel" | case == "big_camel"){
    string <- string %>% 
      stringr::str_split("_") %>% 
      purrr::map(stringr::str_to_title)
    if(is.null(postprocess)){
      string <- string %>% purrr::map_chr(stringr::str_c, collapse = "")
    } else {
      string <- string %>% purrr::map_chr(stringr::str_c, collapse = postprocess)
    }
  }
  if(case == "small_camel"){
    string <- stringr::str_c(stringr::str_sub(string, 1, 1) %>% stringr::str_to_lower(),
                             stringr::str_sub(string, 2))
  }
  # snake- and screaming_snake
  if(case == "snake" | case == "screaming_snake"){
    if(is.null(postprocess)){
      string <- purrr::map_chr(string, ~ stringr::str_replace_all(.x, "_", "_"))
    } else {
      string <- purrr::map_chr(string, ~ stringr::str_replace_all(.x, "_", postprocess))
    }
  }
  ## replace Special Characters
  if(replace_special_characters){
    string <- string %>% purrr::map_chr(~ stringr::str_replace_all(.x, c("\u00C4" = "Ae", 
                                                                         "\u00D6" = "Oe",
                                                                         "\u00DC" = "Ue",
                                                                         "\u00E4" = "ae",
                                                                         "\u00F6" = "oe",
                                                                         "\u00FC" = "ue",
                                                                         "\u00DF" = "ss")))
  }
  ## screaming_snake
  if(case == "screaming_snake"){
    string <- string %>% stringr::str_to_upper()
  }
  ## pre and postfix
  string <- stringr::str_c(prefix, string, postfix)
  ## return
  string
}