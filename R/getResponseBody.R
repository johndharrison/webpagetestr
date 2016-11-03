#' get response body for text resources
#'
#' get response body for text resources
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  request
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A character vector containing the Response body. If 
#'    no Response body is available for the test HTTP 404 error is 
#'    returned.
#' @export
#'
#' @example /inst/examples/docs/getResponseBody.R

getResponseBody <- function(server, testId, run = 1L, repeatView = FALSE, 
                            request = 1L, dryRun = FALSE, ...){
  checkArgs(server, run, request, dryRun)
  body <- list(
    list(testId ,"test"),
    list(run , "run"),
    list(false2Null(repeatView) , "cached"),
    list(request , WPTOptions[["request"]][["api"]])
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- 
    sendQuery(url = server[["url"]], path = WPTPaths[["responseBody"]], 
              body = body, origin = "getResponseBody", dryRun = dryRun,
              method = "GET", ...)
  if(dryRun){return(res)}
  ResponseBody <- content(res)
  ResponseBody
} 
