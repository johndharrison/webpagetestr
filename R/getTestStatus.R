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
  body <- list(
    list(testId , "test"),
    list(requestId , WPTOptions[["requestId"]][["api"]]),
    list("json" , "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["testStatus"]], 
                   body = body, origin = "getTestStatus", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  teststatus <- content(res)
  if(teststatus[["statusCode"]] <= 200L){
    `attr<-`(teststatus[["data"]], "class", "teststatus")
  }else{
    stop("Server returned a statusCode = ", teststatus[["statusCode"]],
         " with statusText = ", teststatus[["statusText"]])
  }
} 

