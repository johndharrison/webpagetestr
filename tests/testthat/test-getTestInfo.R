context("getTestInfo")

test_that("canGetTestInfo", {
  WPT <- server()
  testinfo <- getTestInfo(WPT, testId = "atestid", dryRun = TRUE)  
  expect_identical(
    testinfo, 
    paste0(WPT$url, "/getgzip.php?test=atestid&file=testinfo.json&f=json")
  )
})

test_that("canGetErrorFromGetTestInfo", {
  WPT <- server()
  expect_error(
    getTestInfo(WPT, testId = "atestid"), 
    "Not Found \\(HTTP 404\\)"   
  )
})
