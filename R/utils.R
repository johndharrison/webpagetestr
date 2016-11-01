paths <- 
  list(testStatus = "testStatus.php", 
       testResults = "jsonResult.php", 
       locations = "getLocations.php", 
       testers = "getTesters.php",
       test = "runtest.php", 
       gzip = "getgzip.php", 
       har = "export.php", 
       waterfall = "waterfall.php", 
       thumbnail = "thumbnail.php", 
       cancel = "cancelTest.php", 
       history = "testlog.php", 
       videoCreation = "video/create.php", 
       videoView = "video/view.php", 
       googleCsi = "google/google_csi.php", 
       responseBody = "response_body.php", 
       timeline = "getTimeline.php"
  )

checkArgs <- function(...){
  aNames <- as.character(as.list(substitute(list(...)))[-1L])
  caArgs <- setNames(list(...), aNames)
  if(!is.null(caArgs$server)){
    assert_that(is_server(caArgs$server))
  }
  if(!is.null(caArgs$requestId)){
    assert_that(is_string_or_null(caArgs$requestId))
  }
  if(!is.null(caArgs$testId)){assert_that(is_string(caArgs$testId))}
  
}
