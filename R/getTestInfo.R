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
  body <- list(
    list(testId , "test"),
    list(WPTfileNames$testInfo , "file"),
    list("json" , "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server$url, path = WPTPaths$gzip, 
                   body = body, origin = "getTestInfo", dryRun = dryRun,
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
