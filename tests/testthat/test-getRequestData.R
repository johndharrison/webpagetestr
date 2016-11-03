context("getRequestData")

test_that("cangetRequestDataDryRun", {
  WPT <- server()
  requestData <- getRequestData(WPT, testId = "atestid", run = 2L, 
                             repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    requestData, 
    paste0(WPT[["url"]], 
           "/getgzip.php?test=atestid&file=2_Cached_IEWTR.txt")
  )
})

test_that("canGetErrorFromgetRequestData", {
  WPT <- server()
  expect_error(
    getRequestData(WPT, testId = "atestid"), 
    "getRequestData returned response: 404"   
  )
})

test_that("canGetRequestData", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  requestData <- getRequestData(WPT, tID)
  expect_s3_class(requestData, "tbl_df")
})

