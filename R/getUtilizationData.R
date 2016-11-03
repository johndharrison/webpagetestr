#' Get utilisation data
#'
#' get the CPU, bandwidth and memory utilisation data from test
#' 
#' @template  server 
#' @template  testId 
#' @template  run 
#' @template  repeatView 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A tibble of the CPU, bandwidth and memory utilisation data 
#'    from test
#' @export
#'
#' @example /inst/examples/docs/getUtilizationData.R

getUtilizationData <- function(server, testId, run = 1L, repeatView = FALSE, 
                             dryRun = FALSE, ...){
  checkArgs(server, run, dryRun)
  psfile <- sprintf("%s%s_%s", run, 
                    ifelse(repeatView, WPTfileNames[["cached"]], ""), 
                    WPTfileNames[["utilization"]])
  body <- list(
    list(testId ,"test"),
    list(psfile , "file")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["gzip"]], 
                   body = body, origin = "getUtilizationData", 
                   dryRun = dryRun, method = "GET", ...)
  if(dryRun){return(res)}
  utilization <- content(res, type = "text/csv", encoding = "UTF-8", 
                         col_types = readr::cols(
    "Offset Time (ms)" = "i",
    "Bandwidth In (kbps)" = "i",
    "CPU Utilization (%)" = "n",
    "Memory Use (KB)" = "i"
  ))
  utilization
} 
