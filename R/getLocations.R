#' Get server locations
#'
#' List locations and the number of pending tests
#' 
#' @template  server 
#' @template  requestId 
#' @template ellipsis
#'
#' @return A list of locations and the number of pending tests at those locations
#' @export
#'
#' @example /inst/examples/docs/getLocations.R

getLocations <- function(server, requestId = NULL, ...){
  checkArgs(server, requestId)
  body <- setNames(
    list(requestId, "json"),
    c(WPTOptions$requestId$api, "f")
  )
  res <- sendQuery(url = file.path(server$url, WPTPaths$locations), 
                   body = body, origin = "getLocations", ...)
  locs <- content(res)
  if(identical(locs$statusCode, 200L)){
    `attr<-`(locs$data, "class", "locations")
  }else{
    stop("Server returned a statusCode = ", locs$statusCode,
         " with statusText = ", locs$statusText)
  }
} 

