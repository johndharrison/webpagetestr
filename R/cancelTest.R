#' Cancel test
#'
#' cancel running/pending test
#' 
#' @template  server 
#' @template  testId 
#' @template  key 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A 
#' @export
#'  
#' @example /inst/examples/docs/cancelTest.R

cancelTest <- function(server, testId, 
                       key = Sys.getenv("WPTKEY"), dryRun = FALSE, ...){
  checkArgs(server, testId, key, dryRun)
  body <- list(
    list(testId , "test"),
    list(key , WPTOptions[["key"]][["api"]]),
    list("json" , "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["cancel"]], 
                   body = body, origin = "cancelTest", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  content(res)
  # if(identical(locs[["statusCode"]], 200L)){
  #   `attr<-`(locs[["data"]], "class", "locations")
  # }else{
  #   stop("Server returned a statusCode = ", locs[["statusCode"]],
  #        " with statusText = ", locs[["statusText"]])
  # }
} 

