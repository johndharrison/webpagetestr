context("getConsoleLogData")

test_that("canGetConsoleLogDataDryRun", {
  WPT <- server()
  ConsoleLogData <- getConsoleLogData(WPT, testId = "atestid", run = 2L, 
                                  repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    ConsoleLogData, 
    paste0(WPT$url, 
           "/getgzip.php?test=atestid&file=2_Cached_console_log.json")
  )
})

test_that("canGetErrorFromgetConsoleLogData", {
  WPT <- server()
  expect_error(
    getConsoleLogData(WPT, testId = "atestid"), 
    "getConsoleLogData returned response: 404"   
  )
})

test_that("canGetConsoleLogDataViaMock", {
  WPT <- server()
  with_mock(
    `httr::GET` = function(...){
      list(statusCode = 200L,
           statusText = "Some test info message",
           data = list(hello = "world"))},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x, ...){x},
    expect_is(getConsoleLogData(WPT, "atestid"), "list")
  )
})

