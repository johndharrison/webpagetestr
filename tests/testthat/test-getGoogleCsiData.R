context("getGoogleCsiData")

test_that("canGetGoogleCsiDataDryRun", {
  WPT <- server()
  GoogleCsiData <- getGoogleCsiData(WPT, testId = "atestid", run = 2L, 
                                  repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    GoogleCsiData, 
    paste0(WPT$url, "/google/google_csi.php?test=atestid&run=2&cached=1")
  )
})

test_that("canGetGoogleCsiDataViaMock", {
  WPT <- server()
  with_mock(
    `httr::GET` = function(...){
      list(statusCode = 200L,
           statusText = "Some test info message",
           data = list(hello = "world"))},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x, ...){x},
    expect_is(getGoogleCsiData(WPT, "atestid"), "list")
  )
})

