#' Get server locations
#'
#' List locations and the number of pending tests
#' 
#' @template  server 
#' @template  requestId 
#' @template ellipsis
#'
#' @return
#' @export
#'
#' @examples

getLocations <- function(server, requestId = NULL, ...){
   checkArgs(server, requestId)
} 

