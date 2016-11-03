#' Get testers status
#'
#' list testers status and details
#' 
#' @template server 
#' @template requestId 
#' @template dryRun 
#' @template ellipsis 
#'
#' @return A list of testers status and details
#' @export
#'
#' @example /inst/examples/docs/getTesters.R

getTesters <- function(server, requestId = NULL, dryRun = FALSE, ...){
  checkArgs(server, requestId, dryRun)
  body <- setNames(
    list(requestId, "json"),
    c(WPTOptions[["requestId"]][["api"]], "f")
  )
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["testers"]], 
                   body = body, origin = "getTesters", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  testers <- content(res)
  if(identical(testers[["statusCode"]], 200L)){
    `attr<-`(testers[["data"]], "class", "testers")
  }else{
    stop("Server returned a statusCode = ", testers[["statusCode"]],
         " with statusText = ", testers[["statusText"]])
  }
} 

