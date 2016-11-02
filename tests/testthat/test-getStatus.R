context("getTestStatus")

test_that("canGetStatus", {
  WPT <- server()
  testers <- getTestStatus(WPT, testId = "atestid", 
                           requestId = "areqid", dryRun = TRUE)  
  expect_identical(
    testers, 
    paste0(WPT$url, "/testStatus.php?test=atestid&r=areqid&f=json")
  )
})

test_that("canGetErrorFromGetStatus", {
  WPT <- server()
  expect_error(
    getTestStatus(WPT, testId = "atestid", requestId = "areqid"), 
    "Server returned a statusCode = 400"   
  )
})
