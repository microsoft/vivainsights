% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/track_hr_change.R
\name{track_HR_change}
\alias{track_HR_change}
\title{Sankey chart of organizational movement between HR attributes and
missing values (outside company move) (Data Overview)}
\usage{
track_HR_change(
  data,
  start_date = min(data$MetricDate),
  end_date = max(data$MetricDate),
  hrvar = "Organization",
  mingroup = 5,
  return = "plot",
  NA_replacement = "Out of Company"
)
}
\arguments{
\item{data}{A Person Query dataset in the form of a data frame.}

\item{start_date}{A start date to compare changes. See \code{end_date}.}

\item{end_date}{An end date to compare changes. See \code{start_date}.}

\item{hrvar}{HR Variable by which to compare changes between, defaults to
\code{"Organization"} but accepts any character vector, e.g.
\code{"LevelDesignation"}}

\item{mingroup}{Numeric value setting the privacy threshold / minimum group
size. Defaults to 5.}

\item{return}{Character vector specifying what to return, defaults to
\code{"plot"}. Valid inputs are \code{"plot"} and \code{"table"}.}

\item{NA_replacement}{Character replacement for NA defaults to "out of
company"}
}
\value{
Returns a 'NetworkD3' object by default, where 'plot' is passed in \code{return}.
When 'table' is passed, a summary table is returned as a data frame.
}
\description{
Creates a list of everyone at a specified start date and a specified end date
then aggregates up people who have moved between organizations between this
to points of time and visualizes the move through a sankey chart.

Through this chart you can see:
\itemize{
\item The HR attribute/orgs that have the highest move out
\item The HR attribute/orgs that have the highest move in
\item The number of people that do not have that HR attribute or if they are no
longer in the system
}
}
\examples{

pq_data \%>\% track_HR_change()

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
\code{\link{identify_churn}()},
\code{\link{identify_holidayweeks}()},
\code{\link{identify_inactiveweeks}()},
\code{\link{identify_nkw}()},
\code{\link{identify_outlier}()},
\code{\link{identify_privacythreshold}()},
\code{\link{identify_shifts}()},
\code{\link{identify_tenure}()},
\code{\link{validation_report}()}
}
\author{
Tannaz Sattari Tabrizi \href{mailto:Tannaz.Sattari@microsoft.com}{Tannaz.Sattari@microsoft.com}
}
\concept{Data Validation}
