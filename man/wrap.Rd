% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrap.R
\name{wrap}
\alias{wrap}
\title{Add a character at the start and end of a character string}
\usage{
wrap(string, wrapper = "\\"")
}
\arguments{
\item{string}{Character string to be wrapped around}

\item{wrapper}{Character to wrap around \code{string}}
}
\value{
Character vector containing the modified string.
}
\description{
This function adds a character at the start and end of a character
string, where the default behaviour is to add a double quote.
}
\seealso{
Other Support: 
\code{\link{any_idate}()},
\code{\link{camel_clean}()},
\code{\link{check_inputs}()},
\code{\link{cut_hour}()},
\code{\link{extract_date_range}()},
\code{\link{extract_hr}()},
\code{\link{heat_colours}()},
\code{\link{is_date_format}()},
\code{\link{maxmin}()},
\code{\link{pairwise_count}()},
\code{\link{read_preamble}()},
\code{\link{rgb2hex}()},
\code{\link{totals_bind}()},
\code{\link{totals_col}()},
\code{\link{tstamp}()},
\code{\link{us_to_space}()}
}
\concept{Support}
