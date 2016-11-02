context("getTestStatus")

test_that("canGetTestStatus", {
  WPT <- server()
  status <- getTestStatus(WPT, testId = "atestid", 
                           requestId = "areqid", dryRun = TRUE)  
  expect_identical(
    status, 
    paste0(WPT$url, "/testStatus.php?test=atestid&r=areqid&f=json")
  )
})

test_that("canGetErrorFromGetTestStatus", {
  WPT <- server()
  expect_error(
    getTestStatus(WPT, testId = "atestid", requestId = "areqid"), 
    "Server returned a statusCode = 400"   
  )
})

test_that("canGetTestStatusUsingCurrentTestId", {
  WPT <- server()
  history <- getHistory(WPT)
  tID <- history[["Test ID"]][1]
  status <- getTestStatus(WPT, testId = tID, requestId = "areqid")  
  expect_identical(status$testId, tID)
})

