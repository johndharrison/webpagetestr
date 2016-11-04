#' Get the waterfall PNG image
#'
#' get the waterfall PNG image
#' 
#' @template server 
#' @template testId 
#' @param file Write the result returned to file. Defaults to NULL
#'    = don't write to file
#' @template run 
#' @template repeatView 
#' @template thumbnail
#' @template chartType
#' @template colorByMime
#' @template chartWidth
#' @template maxTime
#' @template wrequests
#' @template noCPU
#' @template noBandwidth
#' @template noEllipsis
#' @template noLabels
#' @template dryRun 
#' @template ellipsis
#'
#' @return If a file argument is given the PNG returned is written to 
#'    file. Else a raster is returned via \link[png]{readPNG}
#' @export
#'
#' @example /inst/examples/docs/getWaterfallImage.R

getWaterfallImage <- function(server, testId, run = 1L, file = NULL, 
                              repeatView = FALSE, thumbnail = FALSE, 
                              # dataURI = FALSE, 
                              chartType = c("waterfall", "connection"),
                              colorByMime = FALSE, chartWidth = NULL,
                              maxTime = NULL, wrequests = NULL, 
                              noCPU = FALSE, noBandwidth = FALSE,
                              noEllipsis = FALSE, noLabels = FALSE,
                              dryRun = FALSE, ...){
  chartType <- match.arg(chartType)
  if(identical(chartType, "waterfall")){
    chartType <- NULL
  }
  if(!is.null(file)){ is_writeable_path(file) }
  checkArgs(server, testId, run, dryRun, repeatView, thumbnail, 
            # dataURI, 
            chartType, colorByMime, chartWidth, maxTime, wrequests, noCPU, 
            noBandwidth, noEllipsis, noLabels)
  psfile <- if(thumbnail){
    sprintf("%s%s_%s", run, 
            ifelse(repeatView, WPTfileNames[["cached"]], ""), 
            WPTfileNames[["waterfall"]])
  }else{
    NULL
  }
  body <- list(
    list(testId ,"test"),
    list(run , "run"),
    list(as.integer(repeatView) , "cached"),
    list(chartType , WPTOptions[["chartType"]][["api"]]),
    list(false2Null(colorByMime) , WPTOptions[["colorByMime"]][["api"]]),
    list(chartWidth , WPTOptions[["chartWidth"]][["api"]]),
    list(maxTime , WPTOptions[["maxTime"]][["api"]]),
    list(wrequests , "requests"),
    list(true2Null(!noCPU) , WPTOptions[["noCPU"]][["api"]]),
    list(true2Null(!noBandwidth) , WPTOptions[["noBandwidth"]][["api"]]),
    list(true2Null(!noEllipsis) , WPTOptions[["noEllipsis"]][["api"]]),
    list(true2Null(!noLabels) , WPTOptions[["noLabels"]][["api"]]),
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
                                 WPTPaths[["waterfall"]]),
                   body = body, origin = "getWaterfallImage", 
                   dryRun = dryRun, 
                   method = ifelse(thumbnail, "GET", "POST"), wfile, ...)
  if(dryRun){return(res)}
  if(!is.null(file)){return()}
  WaterfallImage <- 
    content(res)
  WaterfallImage
} 
