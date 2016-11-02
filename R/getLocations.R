#' Get server locations
#'
#' List locations and the number of pending tests
#' 
#' @template  server 
#' @template  requestId 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A list of locations and the number of pending tests at those locations
#' @export
#'
#' @example /inst/examples/docs/getLocations.R

getLocations <- function(server, requestId = NULL, dryRun = FALSE, ...){
  checkArgs(server, requestId, dryRun)
  body <- setNames(
    list(requestId, "json"),
    c(WPTOptions$requestId$api, "f")
  )
  res <- sendQuery(url = server$url, path = WPTPaths$history, 
                   body = body, origin = "getLocations", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  locs <- content(res)
  if(identical(locs$statusCode, 200L)){
    `attr<-`(locs$data, "class", "locations")
  }else{
    stop("Server returned a statusCode = ", locs$statusCode,
         " with statusText = ", locs$statusText)
  }
} 

