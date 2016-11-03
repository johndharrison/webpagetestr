#' Get Net Log data (chrome)
#'
#' get the Chrome Developer Tools Net log data (if available) from test
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A list containing the Net Log data If no net log data is 
#'    available for the test a HTTP 404 error is returned.
#' @export
#'
#' @example /inst/examples/docs/getNetLogData.R

getNetLogData <- function(server, testId, run = 1L, repeatView = FALSE, 
                            dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  psfile <- sprintf("%s%s_%s", run, 
                    ifelse(repeatView, WPTfileNames$cached, ""), 
                    WPTfileNames$netLog)
  body <- list(
    list(testId ,"test"),
    list(psfile , "file")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server$url, path = WPTPaths$gzip, body = body, 
                   origin = "getNetLogData", dryRun = dryRun,
                   method = "GET", ...)
  if(dryRun){return(res)}
  NetLogData <- 
    content(res, type = "application/json", encoding = "UTF-8")
  NetLogData
} 
