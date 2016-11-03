#' Get HAR data
#'
#' get the HTTP Archive (HAR) from test
#'
#' @template server 
#' @template testId
#' @template requestId
#' @template breakDown
#' @template domains
#' @template pageSpeed
#' @template requests
#' @template medianMetric
#' @template medianRun
#' @template dryRun 
#' @template ellipsis
#'
#' @return returns a parsed HAR object from \code{\link[HARtools]{readHAR}}
#' @export
#'
#' @example /inst/examples/docs/getTestResults.R

getTestResults <- function(server, testId, requestId = NULL, 
                           breakDown = FALSE, domains = FALSE, 
                           pageSpeed = FALSE, requests = FALSE,
                           medianMetric = NULL, medianRun = NULL,
                           dryRun = FALSE, ...){
  checkArgs(server, testId, requestId, breakDown, domains, pageSpeed, 
            requests, medianMetric, medianRun, dryRun)
  body <- list(
    list(testId, "test"),
    list(requestId, WPTOptions[["requestId"]][["api"]]),
    list(false2Null(breakDown), WPTOptions[["breakDown"]][["api"]]),
    list(false2Null(domains), WPTOptions[["domains"]][["api"]]),
    list(false2Null(pageSpeed), WPTOptions[["pageSpeed"]][["api"]]),
    list(false2Null(requests), WPTOptions[["requests"]][["api"]]),
    list(medianMetric, WPTOptions[["medianMetric"]][["api"]]),
    list(medianRun, WPTOptions[["medianRun"]][["api"]]),
    list("json", "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["testResults"]], 
                   body = body, origin = "getTestResults", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  testResults <- content(res)
  if(testResults[["statusCode"]] <= 200L){
    `attr<-`(testResults[["data"]], "class", "testresults")
  }else{
    stop("Server returned a statusCode = ", testResults[["statusCode"]],
         " with statusText = ", testResults[["statusText"]])
  }
} 
