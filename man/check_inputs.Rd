% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/supporting_functions.R
\name{check_inputs}
\alias{check_inputs}
\title{Check whether a data frame contains all the required variable}
\usage{
check_inputs(input, requirements, return = "stop")
}
\arguments{
\item{input}{Pass a data frame for checking}

\item{requirements}{A character vector specifying the required variable names}

\item{return}{A character string specifying what to return.
The default value is "stop". Also accepts "names" and "warning".}
}
\value{
The default behaviour is to return an error message, informing the
user what variables are not included. When \code{return} is set to "names", a
character vector containing the unmatched variable names is returned.
}
\description{
Checks whether a data frame contains all the required variables.
Matching works via variable names, and used to support individual
functions in the package. Not used directly.
}
\examples{

# Return error message
\dontrun{
check_inputs(iris, c("Sepal.Length", "mpg"))
}

#' # Return warning message
check_inputs(iris, c("Sepal.Length", "mpg"), return = "warning")

# Return variable names
check_inputs(iris, c("Sepal.Length", "Sepal.Width", "RandomVariable"), return = "names")

}
\seealso{
Other Support: 
\code{\link{any_idate}()},
\code{\link{camel_clean}()},
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
\code{\link{us_to_space}()},
\code{\link{wrap}()}
}
\concept{Support}
