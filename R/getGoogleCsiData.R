#' get Google CSI data
#'
#' get Google CSI data (Client Side Instrumentation)
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A tibble of Google CSI data (Client Side Instrumentation). If 
#'    no CSI data is available for the test a blank tibble is returned.
#' @export
#'
#' @example /inst/examples/docs/getGoogleCsiData.R

getGoogleCsiData <- function(server, testId, run = 1L, repeatView = FALSE, 
                              dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  body <- list(
    list(testId ,"test"),
    list(run , "run"),
    list(false2Null(repeatView) , "cached")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["googleCsi"]], 
                   body = body, origin = "getGoogleCsiData", 
                   dryRun = dryRun, method = "GET", ...)
  if(dryRun){return(res)}
  GoogleCsi <- content(res)
  GoogleCsi
} 
