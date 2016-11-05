#' Get the Screenshot PNG image
#'
#' get the fully loaded page screenshot in JPG format (PNG if in full 
#'    resolution)
#' 
#' @template server 
#' @template testId 
#' @param file Write the result returned to file. Defaults to NULL
#'    = don't write to file
#' @template run 
#' @template repeatView 
#' @template thumbnail
#' @template fullResolution
#' @template startRender
#' @template documentComplete
#' @template dryRun 
#' @template ellipsis
#'
#' @return If a file argument is given the JPG/PNG returned is written to 
#'    file. Else a raster is returned via
#'     \link[jpeg]{readJPEG}|\link[png]{readPNG}. If a file is not 
#'     available when calling an argument (for example fullres, 
#'     docComplete, ....) a HTTP 404 Not found error is returned.
#' @export
#'
#' @example /inst/examples/docs/getScreenshotImage.R

getScreenshotImage <- function(server, testId, run = 1L, file = NULL, 
                               repeatView = FALSE, thumbnail = FALSE, 
                               fullResolution = FALSE, startRender = FALSE,
                               documentComplete = FALSE, dryRun = FALSE, 
                               ...){
  
  if(!is.null(file)){ 
    assert_that(is_writeable_path(file))
  }
  checkArgs(server, testId, run, dryRun, repeatView, thumbnail, 
            fullResolution, startRender, documentComplete)
  screenSType <- if(startRender){
    WPTfileNames[["screenshotStartRender"]]
  }else if(documentComplete){
    WPTfileNames[["screenshotDocumentComplete"]]
  }else if(fullResolution){
    WPTfileNames[["screenshotFullResolution"]]
  }else{
    WPTfileNames[["screenshot"]]
  }
  psfile <- sprintf("%s%s_%s", run, 
                    ifelse(repeatView, WPTfileNames[["cached"]], ""), 
                    screenSType)
  repeatView <- as.integer(repeatView)
  if(!thumbnail){
    run <- NULL
    repeatView <- NULL
  }
  
  body <- list(
    list(testId ,"test"),
    list(run , "run"),
    list(repeatView , "cached"),
    list(psfile , "file")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))
  wfile <- if(!is.null(file)){
    httr::write_disk(file, overwrite = TRUE)
  }else{
    NULL
  }
  res <- sendQuery(url = server[["url"]], 
                   path = ifelse(thumbnail, WPTPaths[["thumbnail"]], 
                                 WPTPaths[["gzip"]]),
                   body = body, origin = "getScreenshotImage", 
                   dryRun = dryRun, 
                   method = "GET", wfile, ...)
  if(dryRun){return(res)}
  if(!is.null(file)){return()}
  ScreenshotImage <- 
    content(res, type = 
              switch(tools::file_ext(body[["file"]]),
                     "jpg" = "image/jpeg",
                     "png" = "image/png")
    )
  ScreenshotImage
} 
