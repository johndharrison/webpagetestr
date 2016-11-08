#' Create video
#'
#' create a video from <tests> (character vector of test ids)
#' 
#' @template  server 
#' @template  tests 
#' @template  comparisonEndPoint 
#' @template  dryRun 
#' @template ellipsis
#'
#' @return A 
#' @export
#'  
#' @example /inst/examples/docs/createVideo.R

createVideo <- function(server, tests, 
                        comparisonEndPoint = c("visual", "all", 
                                               "doc", "full"), 
                        dryRun = FALSE, ...){
  checkArgs(server, tests, comparisonEndPoint, dryRun)
  comparisonEndPoint <- match.arg(comparisonEndPoint)
  tests <- paste(tests, collapse = ",")
  body <- list(
    list(tests , "tests"),
    list(comparisonEndPoint , WPTOptions[["comparisonEndPoint"]][["api"]]),
    list("json" , "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server[["url"]], 
                   path = WPTPaths[["videoCreation"]], body = body, 
                   origin = "createVideo", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  vidRes <- content(res)
  if(identical(vidRes[["statusCode"]], 200L)){
    return(vidRes[["data"]])
  }else{
    stop("Server returned a statusCode = ", vidRes[["statusCode"]],
         " with statusText = ", vidRes[["statusText"]])
  }
} 

