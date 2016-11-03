context("getTestInfo")

test_that("canGetTestInfo", {
  WPT <- server()
  testinfo <- getTestInfo(WPT, testId = "atestid", dryRun = TRUE)  
  expect_identical(
    testinfo, 
    paste0(WPT[["url"]], "/getgzip.php?test=atestid&file=testinfo.json&f=json")
  )
})

test_that("canGetErrorFromGetTestInfo", {
  WPT <- server()
  expect_error(
    getTestInfo(WPT, testId = "atestid"), 
    "Not Found \\(HTTP 404\\)"   
  )
})

test_that("canGetErrorFromGetTestInfoViaMock", {
  WPT <- server()
  with_mock(
    `httr::POST` = function(...){
      list(statusCode = 400L,
           statusText = "Some test info error")},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_error(
      getTestInfo(WPT, testId = "atestid"), 
      "Server returned a statusCode = 400"   
    )
  )
})

test_that("canGetTestInfoViaMock", {
  WPT <- server()
  with_mock(
    `httr::POST` = function(...){
      list(statusCode = 200L,
           statusText = "Some test info message",
           data = list(hello = "world"))},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_s3_class(
      getTestInfo(WPT, testId = "atestid"), 
      "testinfo"   
    )
  )
})

