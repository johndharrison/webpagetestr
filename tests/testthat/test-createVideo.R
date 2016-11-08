context("createVideo")

test_that("canCreateVideo", {
  WPT <- server()
  history <- getHistory(WPT, days = 10L, filter = "google.com")
  tests <- tail(history[["Test ID"]], 5)
  vidRes <- createVideo(WPT, tests = tests)
  expect_identical(names(vidRes), c("videoId", "jsonUrl", "userUrl"))
})
