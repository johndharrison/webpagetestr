context("getPageSpeedData")

test_that("canGetPageSpeedData", {
  WPT <- server()
  pagespeed <- getPageSpeedData(WPT, testId = "atestid", run = 2L, 
                             repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    pagespeed, 
    paste0(WPT[["url"]], 
           "/getgzip.php?test=atestid&file=2_Cached_pagespeed.txt")
  )
})

test_that("canGetErrorFromGetPageSpeedData", {
  WPT <- server()
  expect_error(
    getPageSpeedData(WPT, testId = "atestid"), 
    "getPageSpeedData returned response: 404"   
  )
})

test_that("canGetPageSpeedDataUsingOldTestId", {
  WPT <- server()
  tID <- "121216_XZ_AA"
  pagespeed <- getPageSpeedData(WPT, testId = tID)  
  expect_false(is.null(pagespeed[["score"]]))
})

