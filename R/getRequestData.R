#' Get request data
#'
#' get the request data from test
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A tibble containing the request data
#' @export
#'
#' @example /inst/examples/docs/getRequestData.R

getRequestData <- function(server, testId, run = 1L, repeatView = FALSE, 
                             dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  psfile <- sprintf("%s%s_%s", run, 
                    ifelse(repeatView, WPTfileNames[["cached"]], ""), 
                    WPTfileNames[["request"]])
  body <- list(
    list(testId ,"test"),
    list(psfile , "file")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["gzip"]], 
                   body = body, origin = "getRequestData", 
                   dryRun = dryRun, method = "GET", ...)
  if(dryRun){return(res)}
  requestdata <- 
    parseRequestData(content(res, as = "text", encoding = "UTF-8"))
  requestdata
} 
