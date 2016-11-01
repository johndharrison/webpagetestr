#' check test status
#'
#' @template server 
#' @template testId
#' @template requestId 
#' @template ellipsis
#'
#' @return returns the status of a test
#' @export
#'
#' @example /inst/examples/docs/getStatus.R

getTestStatus <- function(server, testId ,requestId = NULL, ...){
  checkArgs(server = server, testId ,requestId = requestId)
} 

