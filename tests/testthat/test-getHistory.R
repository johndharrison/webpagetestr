context("getHistory")

test_that("canGetHistoryDryRun", {
  WPT <- server()
  history <- getHistory(WPT, dryRun = TRUE)  
  expect_identical(
    history, 
    paste0(WPT[["url"]], "/testlog.php?days=1&f=csv&all=on")
  )
})

test_that("canGetHistory", {
  WPT <- server()
  history <- getHistory(WPT) 
  expect_s3_class(history, "tbl_df")
})

test_that("canGetHistoryFilter", {
  WPT <- server()
  history <- getHistory(WPT, days = 10L, filter = "google.com") 
  expect_s3_class(history, "tbl_df")
})
