% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/identify_churn.R
\name{identify_churn}
\alias{identify_churn}
\title{Identify employees who have churned from the dataset}
\usage{
identify_churn(data, n1 = 6, n2 = 6, return = "message", flip = FALSE)
}
\arguments{
\item{data}{A Person Query as a data frame. Must contain a \code{PersonId}.}

\item{n1}{A numeric value specifying the number of weeks at the beginning of
the period that defines the measured employee set. Defaults to 6.}

\item{n2}{A numeric value specifying the number of weeks at the end of the
period to calculate whether employees have churned from the data. Defaults
to 6.}

\item{return}{String specifying what to return. This must be one of the
following strings:
\itemize{
\item \code{"message"} (default)
\item \code{"text"}
\item \code{"data"}
}

See \code{Value} for more information.}

\item{flip}{Logical, defaults to FALSE. This determines whether to reverse
the logic of identifying the non-overlapping set. If set to \code{TRUE}, this
effectively identifies new-joiners, or those who were not present in the
first n weeks of the data but were present in the final n weeks.}
}
\value{
A different output is returned depending on the value passed to the \code{return}
argument:
\itemize{
\item \code{"message"}: Message on console. A diagnostic message.
\item \code{"text"}: String. A diagnostic message.
\item \code{"data"}: Character vector containing the the \code{PersonId} of
employees who have been identified as churned.
}
}
\description{
This function identifies and counts the number of employees who have churned
from the dataset by measuring whether an employee who is present in the first
\code{n} (n1) weeks of the data is present in the last \code{n} (n2) weeks of the data.
}
\details{
An additional use case of this function is the ability to identify
"new-joiners" by using the argument \code{flip}.

If an employee is present in the first \code{n} weeks of the data but not present
in the last \code{n} weeks of the data, the function considers the employee as
churned. As the measurement period is defined by the number of weeks from the
start and the end of the passed data frame, you may consider filtering the
dates accordingly before running this function.

Another assumption that is in place is that any employee whose \code{PersonId} is
not available in the data has churned. Note that there may be other reasons
why an employee's \code{PersonId} may not be present, e.g. maternity/paternity
leave, Viva Insights license has been removed, shift to a
low-collaboration role (to the extent that he/she becomes inactive).
}
\examples{
pq_data \%>\% identify_churn(n1 = 3, n2 = 3, return = "message")

}
\seealso{
Other Data Validation: 
\code{\link{check_query}()},
\code{\link{extract_hr}()},
\code{\link{flag_ch_ratio}()},
\code{\link{flag_em_ratio}()},
\code{\link{flag_extreme}()},
\code{\link{flag_outlooktime}()},
\code{\link{hr_trend}()},
\code{\link{hrvar_count}()},
\code{\link{hrvar_count_all}()},
\code{\link{hrvar_trend}()},
\code{\link{identify_holidayweeks}()},
\code{\link{identify_inactiveweeks}()},
\code{\link{identify_nkw}()},
\code{\link{identify_outlier}()},
\code{\link{identify_privacythreshold}()},
\code{\link{identify_shifts}()},
\code{\link{identify_tenure}()},
\code{\link{track_HR_change}()},
\code{\link{validation_report}()}
}
\concept{Data Validation}
