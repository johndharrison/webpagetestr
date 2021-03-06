#' Get server locations
#'
#' List locations and the number of pending tests
#' 
#' @template  server 
#' @template  requestId 
#' @template  key 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A list of locations and the number of pending tests at those 
#'     locations
#' @export
#'  
#' @example /inst/examples/docs/getLocations.R

getLocations <- function(server, requestId = NULL, 
                         key = Sys.getenv("WPTKEY"), dryRun = FALSE, ...){
  if(identical(key, "")){key <- NULL}
  checkArgs(server, requestId, key, dryRun)
  body <- list(
    list(requestId , WPTOptions[["requestId"]][["api"]]),
    list(key , WPTOptions[["key"]][["api"]]),
    list("json" , "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["locations"]], 
                   body = body, origin = "getLocations", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  locs <- content(res)
  if(identical(locs[["statusCode"]], 200L)){
    `attr<-`(locs[["data"]], "class", "locations")
  }else{
    stop("Server returned a statusCode = ", locs[["statusCode"]],
         " with statusText = ", locs[["statusText"]])
  }
} 

