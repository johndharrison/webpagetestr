context("getHARData")

test_that("canGetHARData", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  har <- getHARData(WPT, tID)
  expect_s3_class(har, "har")
})

test_that("canGetHARDataDryRun", {
  WPT <- server()
  har <- getHARData(WPT, "someID", dryRun = TRUE)
  expect_identical(
    har, 
    paste0(WPT$url, "/export.php?test=someID&f=json")
  )
})
