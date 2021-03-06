% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getTimelineData.R
\name{getTimelineData}
\alias{getTimelineData}
\title{Get timeline data (chrome)}
\usage{
getTimelineData(server, testId, run = 1L, repeatView = FALSE,
  dryRun = FALSE, ...)
}
\arguments{
\item{server}{A WebPagetest server}

\item{testId}{test ID string}

\item{run}{an integer. Which run number on a multiple runs test. 
Defaults to 1L.}

\item{repeatView}{get the Repeat View (cached view) instead of default 
First View (primed cache). Defaults to FALSE}

\item{dryRun}{If TRUE just return the RESTful API URL. Defaults to 
FALSE}

\item{...}{Additonal function arguments}
}
\value{
A list containing the timeline
}
\description{
get the Chrome Developer Tools Timeline data (if available) from test
}
\examples{
\dontrun{
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  timelineData <- getTimelineData(WPT, tID)
}
}

