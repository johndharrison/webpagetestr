#' Get test info
#'
#' get test request info/details
#'
#' @template server 
#' @template testId
#' @template  dryRun 
#' @template ellipsis
#'
#' @return returns info on a test
#' @export
#'
#' @example /inst/examples/docs/getTestInfo.R

getTestInfo <- function(server, testId , dryRun = FALSE, ...){
  checkArgs(server, testId, dryRun)
  body <- setNames(
    list(testId, "json"),
    c("test", "f")
  )
  res <- sendQuery(url = file.path(server$url, WPTPaths$testStatus), 
                   body = body, origin = "getTestStatus", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  testinfo <- content(res)
  if(identical(testinfo$statusCode, 200L)){
    `attr<-`(testinfo$data, "class", "testinfo")
  }else{
    stop("Server returned a statusCode = ", testinfo$statusCode,
         " with statusText = ", testinfo$statusText)
  }
} 
