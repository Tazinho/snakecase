#' Internal helper to protect non alphanumerics (delete the separators around them).
#'
#' @param string A string (for example names of a data frame).
#' @param protect A string which is a valid \code{stringr::regex()}. Matches within the output
#' won't have any "_" (or artifacts of \code{preprocess}) beside. Note that \code{preprocess} has a higher precedence than protect, 
#' which means that it doesn't make sense to protect sth. which is already replaced
#' via \code{preprocess}.
#' 
#' @return A character vector.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'
protect_internal <- function(string, protect = NULL){
  postprocess_protector <- "_"
  protect <- stringr::str_c("([", protect, "])")
  infront <- stringr::str_c(postprocess_protector , "+", protect)
  behind <- stringr::str_c(protect, postprocess_protector, "+")
  string <- stringr::str_replace_all(string, infront, "\\1") %>% 
    stringr::str_replace_all(behind, "\\1")
  
  string
} 