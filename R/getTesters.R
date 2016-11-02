#' Get testers status
#'
#' list testers status and details
#' 
#' @template server 
#' @template requestId 
#' @template dryrun 
#' @template ellipsis 
#'
#' @return A list of testers status and details
#' @export
#'
#' @example /inst/examples/docs/getTesters.R

getTesters <- function(server, requestId = NULL, dryrun = FALSE, ...){
  checkArgs(server, requestId, dryrun)
  body <- setNames(
    list(requestId, "json"),
    c(WPTOptions$requestId$api, "f")
  )
  res <- sendQuery(url = file.path(server$url, WPTPaths$testers), 
                   body = body, origin = "getTesters", dryrun = dryrun,
                   ...)
  if(dryrun){return(res)}
  testers <- content(res)
  if(identical(testers$statusCode, 200L)){
    `attr<-`(testers$data, "class", "testers")
  }else{
    stop("Server returned a statusCode = ", testers$statusCode,
         " with statusText = ", testers$statusText)
  }
} 

