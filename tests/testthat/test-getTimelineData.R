context("getTimelineData")

test_that("canGetTimelineDataDryRun", {
  WPT <- server()
  timelineData <- getTimelineData(WPT, testId = "atestid", run = 2L, 
                                  repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    timelineData, 
    paste0(WPT[["url"]], "/getTimeline.php?test=atestid&run=2&cached=1")
  )
})

test_that("canGetErrorFromgetTimelineData", {
  WPT <- server()
  expect_error(
    getTimelineData(WPT, testId = "atestid"), 
    "getTimelineData returned response: 404"   
  )
})

test_that("canGetTimelineDataViaMock", {
  WPT <- server()
  with_mock(
    `httr::GET` = function(...){
      list(statusCode = 200L,
           statusText = "Some test info message",
           data = list(hello = "world"))},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_is(getTimelineData(WPT, "atestid"), "list")
  )
})

