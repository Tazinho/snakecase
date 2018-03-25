#' Internal helper for "lower_upper", "upper_lower".
#' This helper returns a logical vector with TRUE for the 
#' first and every second string of those which contain 
#' an alphabetic character
#'
#' @param string A string (for example names of a data frame).
#' 
#' @return A logical vector.
#'
#' @author Malte Grosser, \email{malte.grosser@@gmail.com}
#' @keywords utilities
#'

relevant <- function(string){
    relevant <- stringr::str_detect(string, "[:alpha:]")
    relevant[relevant] <- rep_len(c(TRUE, FALSE), sum(relevant))
    relevant
}
