#' Get test history
#'
#' Get history of previously run tests
#' 
#' @template  server 
#' @param  days Number of days to get history for defaults to 1L.
#' @param filter optional string to filter the results against
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A tibble with "Date/Time", "Location", "Test ID", "URL","Label" 
#'    of tests. NOTE: The results returned are limited on default server.
#' @export
#'
#' @example /inst/examples/docs/getHistory.R

getHistory <- function(server, days = 1L, filter = NULL, dryRun = FALSE, ...){
  checkArgs(server, days, dryRun)
  body <- list(
    list(days , "days"),
    list("csv" , "f"),
    list("on" , "all"),
    list(filter , "filter")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server$url, path = WPTPaths$history, 
                   body = body, origin = "getHistory", dryRun = dryRun,
                   method = "GET", ...)
  if(dryRun){return(res)}
  history <- 
    content(res, col_types = readr::cols(
      "Date/Time" = readr::col_datetime("%m/%d/%y %H:%M:%S"),
      Location = "c",
      "Test ID" = "c",
      "URL" = "c",
      Label = "c"
    ))
  history
} 

