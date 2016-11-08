context("getEmberVideoPlayer")

test_that("canGetEmberVideoPlayer", {
  WPT <- server()
  history <- getHistory(WPT, days = 10L, filter = "google.com")
  testid <- tail(history[["Test ID"]], 1)
  vidRes <- getEmbedVideoPlayer(WPT, testid)
  expect_s3_class(vidRes, "xml_document")
})

test_that("canGetEmberVideoPlayerWriteFile", {
  WPT <- server()
  tFile <- tempfile(fileext = ".html")
  history <- getHistory(WPT, days = 10L, filter = "google.com")
  testid <- tail(history[["Test ID"]], 1)
  vidRes <- getEmbedVideoPlayer(WPT, testid, file = tFile)
  expect_true(file.exists(tFile))
})
