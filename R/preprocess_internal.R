#' Internal function that replaces regex matches with underscores
#'
#' @param string A string.
#' @param sep_in (short for separator input) A regex supplied as a character (if not \code{NULL}), which will be wrapped internally
#' into \code{stringr::regex()}. All matches will be replaced by underscores (additionally to 
#' \code{"_"} and \code{" "}, for which this is always true). Underscores can later turned into another separator via \code{postprocess}.
#' 
#' @return A character containing the parsed string.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
preprocess_internal <- function(string, sep_in){
  if(!is.null(sep_in)){
    string <- stringr::str_replace_all(string, sep_in, "_")
  }
  string
}