context("getChromeTraceData")

test_that("canGetChromeTraceDataDryRun", {
  WPT <- server()
  ChromeTraceData <- getChromeTraceData(WPT, testId = "atestid", run = 2L, 
                                  repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    ChromeTraceData, 
    paste0(WPT[["url"]], "/getgzip.php?test=atestid&file=2_Cached_trace.json")
  )
})

test_that("canGetErrorFromgetChromeTraceData", {
  WPT <- server()
  expect_error(
    getChromeTraceData(WPT, testId = "atestid"), 
    "getChromeTraceData returned response: 404"   
  )
})

test_that("canGetChromeTraceDataViaMock", {
  WPT <- server()
  with_mock(
    `httr::GET` = function(...){
      list(statusCode = 200L,
           statusText = "Some test info message",
           data = list(hello = "world"))},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x, ...){x},
    expect_is(getChromeTraceData(WPT, "atestid"), "list")
  )
})

