#' Get timeline data (chrome)
#'
#' get the Chrome Developer Tools Timeline data (if available) from test
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A list containing the timeline
#' @export
#'
#' @example /inst/examples/docs/getTimelineData.R

getTimelineData <- function(server, testId, run = 1L, repeatView = FALSE, 
                           dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  body <- list(
    list(testId ,"test"),
    list(run , "run"),
    list(false2Null(repeatView) , "cached")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["timeline"]], 
                   body = body, origin = "getTimelineData", 
                   dryRun = dryRun, method = "GET", ...)
  if(dryRun){return(res)}
  timelinedata <- content(res)
  timelinedata
} 
