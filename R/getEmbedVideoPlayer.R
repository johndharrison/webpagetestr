#' Get embedded video player
#'
#' get a html5 player for a video <id>
#' 
#' @template  server 
#' @template  testId 
#' @param file Write the result returned to file. Defaults to NULL
#'    = don't write to file
#' @template  dryRun 
#' @template ellipsis
#'
#' @return Writes a html file with embedded video if file argument is not
#' NULL else returns HTML.
#' @export
#'  
#' @example /inst/examples/docs/getEmbedVideoPlayer.R

getEmbedVideoPlayer <- function(server, testId, file = NULL, 
                                dryRun = FALSE, ...){
  checkArgs(server, testId, file, dryRun)
  body <- list(
    list(testId , "id"),
    list(1L , "embed")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  wfile <- if(!is.null(file)){
    httr::write_disk(file, overwrite = TRUE)
  }else{
    NULL
  }
  res <- sendQuery(url = server[["url"]], 
                   path = WPTPaths[["videoView"]], body = body, 
                   origin = "getEmbedVideoPlayer", dryRun = dryRun,
                   method = "GET", wfile, ...)
  if(dryRun){return(res)}
  if(!is.null(file)){return()}
  vidRes <- content(res)
  vidRes
} 
