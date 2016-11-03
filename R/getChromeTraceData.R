#' Get the Chrome Trace data (chrome)
#'
#' get the Chrome Trace data (if available) from test
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A list containing the Chrome Trace data. If no Chrome Trace 
#'    data is available for the test a HTTP 404 error is returned.
#' @export
#'
#' @example /inst/examples/docs/getChromeTraceData.R

getChromeTraceData <- function(server, testId, run = 1L, repeatView = FALSE, 
                          dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  psfile <- sprintf("%s%s_%s", run, 
                    ifelse(repeatView, WPTfileNames$cached, ""), 
                    WPTfileNames$chromeTrace)
  body <- list(
    list(testId ,"test"),
    list(psfile , "file")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server$url, path = WPTPaths$gzip, body = body, 
                   origin = "getChromeTraceData", dryRun = dryRun,
                   method = "GET", ...)
  if(dryRun){return(res)}
  ChromeTrace <- 
    content(res, type = "application/json", encoding = "UTF-8")
  ChromeTrace
} 
