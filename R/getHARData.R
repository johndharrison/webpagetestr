#' Get HAR data
#'
#' get the HTTP Archive (HAR) from test
#'
#' @template server 
#' @template testId
#' @template  dryRun 
#' @template ellipsis
#'
#' @return returns a parsed HAR object from \code{\link[HARtools]{readHAR}}
#' @export
#'
#' @example /inst/examples/docs/getHARData.R

getHARData <- function(server, testId , dryRun = FALSE, ...){
  checkArgs(server, testId, dryRun)
  body <- setNames(
    list(testId, WPTfileNames$testInfo, "json"),
    c("test", "file", "f")
  )
  res <- sendQuery(url = server$url, path = WPTPaths$har, 
                   body = body, origin = "getHARData", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  hardata <- content(res)
  readHAR(hardata)
} 
