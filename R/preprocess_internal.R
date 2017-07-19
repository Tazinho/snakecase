#' Internal function that replaces regex matches with underscores
#'
#' @param string A string.
#' @param preprocess Character string that will be wrapped internally into stringr::regex. 
#' All matches will be padded with underscores.
#' 
#' @return A character containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
preprocess_internal <- function(string, preprocess){
  if(!is.null(preprocess)){
    string <- stringr::str_replace_all(string, preprocess, "_")
  }
  string
}