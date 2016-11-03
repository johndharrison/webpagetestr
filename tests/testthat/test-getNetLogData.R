context("getNetLogData")

test_that("canGetNetLogDataDryRun", {
  WPT <- server()
  NetLogData <- getNetLogData(WPT, testId = "atestid", run = 2L, 
                                  repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    NetLogData, 
    paste0(WPT[["url"]], "/getgzip.php?test=atestid&file=2_Cached_netlog.txt")
  )
})

test_that("canGetErrorFromgetNetLogData", {
  WPT <- server()
  expect_error(
    getNetLogData(WPT, testId = "atestid"), 
    "getNetLogData returned response: 404"   
  )
})

test_that("canGetNetLogDataViaMock", {
  WPT <- server()
  with_mock(
    `httr::GET` = function(...){
      list(statusCode = 200L,
           statusText = "Some test info message",
           data = list(hello = "world"))},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x, ...){x},
    expect_is(getNetLogData(WPT, "atestid"), "list")
  )
})

