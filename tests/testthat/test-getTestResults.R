context("getTestResults")

test_that("canGetTestResults", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  testresults <- getTestResults(WPT, tID, requestId = "someID")
  expect_s3_class(testresults, "testresults")
})

test_that("canGetTestResultsDryRun", {
  WPT <- server()
  testresults <- 
    getTestResults(WPT, "someId", breakDown = TRUE, domains = TRUE, 
                   pageSpeed = TRUE, requests = TRUE, 
                   medianMetric = "SpeedIndex", medianRun = "fastest", 
                   dryRun = TRUE)
  expect_identical(
    testresults, 
    paste0(WPT$url, "/jsonResult.php?test=someId&breakdown=1&domains=1",
           "&pagespeed=1&requests=1&", 
           "medianMetric=SpeedIndex&medianRun=fastest&f=json")
  )
})

test_that("canGetErrorFromGetTestResults", {
  WPT <- server()
  with_mock(
    `httr::POST` = function(...){
      list(statusCode = 400L,
           statusText = "Some location error")},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_error(
      getTestResults(WPT, "someId"), "Server returned a statusCode = 400"   
    )
  )
})

