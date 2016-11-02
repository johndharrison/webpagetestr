#' check test status
#'
#' check the status of a test
#'
#' @template server 
#' @template testId
#' @template requestId 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return returns the status of a test
#' @export
#'
#' @example /inst/examples/docs/getStatus.R

getTestStatus <- function(server, testId ,requestId = NULL, dryRun = FALSE, ...){
  checkArgs(server, testId, requestId, dryRun)
  body <- setNames(
    list(testId, requestId, "json"),
    c("test", WPTOptions$requestId$api, "f")
  )
  res <- sendQuery(url = server$url, path = WPTPaths$history, 
                   body = body, origin = "getTestStatus", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  teststatus <- content(res)
  if(identical(teststatus$statusCode, 200L)){
    `attr<-`(teststatus$data, "class", "teststatus")
  }else{
    stop("Server returned a statusCode = ", teststatus$statusCode,
         " with statusText = ", teststatus$statusText)
  }
} 

