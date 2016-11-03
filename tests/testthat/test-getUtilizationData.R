context("getUtilizationData")

test_that("cangetUtilizationDataDryRun", {
  WPT <- server()
  utilizationData <- getUtilizationData(WPT, testId = "atestid", run = 2L, 
                             repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    utilizationData, 
    paste0(WPT[["url"]], 
           "/getgzip.php?test=atestid&file=2_Cached_progress.csv")
  )
})

test_that("canGetErrorFromgetUtilizationData", {
  WPT <- server()
  expect_error(
    getUtilizationData(WPT, testId = "atestid"), 
    "getUtilizationData returned response: 404"   
  )
})

test_that("cangetUtilizationData", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  utilizationData <- getUtilizationData(WPT, tID)
  expect_s3_class(utilizationData, "tbl_df")
})

