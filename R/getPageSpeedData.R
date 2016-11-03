#' Get Page Speed results
#'
#' get the Google Page Speed results (if available) from test
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A list of Google Page Speed results (if available) from test.
#'    It is unlikely pagespeed data is available for recent tests.
#'    See \url{https://github.com/WPO-Foundation/webpagetest/issues/669}.
#'    If the Page Speed data is not available a HTTP 404 not found error
#'    will be returned.
#' @export
#'
#' @example /inst/examples/docs/getPageSpeedData.R

getPageSpeedData <- function(server, testId, run = 1L, repeatView = FALSE, 
                             dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  psfile <- sprintf("%s%s_%s", run, 
                    ifelse(repeatView, WPTfileNames$cached, ""), 
                    WPTfileNames$pageSpeed)
  body <- list(
    list(testId ,"test"),
    list(psfile , "file")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server$url, path = WPTPaths$gzip, body = body, 
                   origin = "getPageSpeedData", dryRun = dryRun,
                   method = "GET", ...)
  if(dryRun){return(res)}
  pagespeed <- content(res)
  pagespeed
} 

