% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parsing_helpers_internal.R
\name{parsing_helpers}
\alias{parsing_helpers}
\alias{parse1_pat_cap_smalls}
\alias{parse2_pat_digits}
\alias{parse3_pat_caps}
\alias{parse4_pat_cap}
\alias{parse5_pat_non_alnums}
\alias{parse6_mark_digits}
\alias{parse7_pat_caps_smalls}
\alias{parse8_pat_smalls_after_non_alnums}
\title{Parsing helpers}
\usage{
parse1_pat_cap_smalls(string)

parse2_pat_digits(string)

parse3_pat_caps(string)

parse4_pat_cap(string)

parse5_pat_non_alnums(string)

parse6_mark_digits(string)

parse7_pat_caps_smalls(string)

parse8_pat_smalls_after_non_alnums(string)
}
\arguments{
\item{string}{A string.}
}
\value{
A partly parsed character vector.
}
\description{
Mainly for usage within \code{to_parsed_case_internal}
}
\author{
Malte Grosser, \email{malte.grosser@gmail.com}
}
\keyword{utilities}
