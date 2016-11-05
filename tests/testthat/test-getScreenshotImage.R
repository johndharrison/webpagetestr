context("getScreenshotImage")

test_that("canGetScreenshotImage", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  img <- getScreenshotImage(WPT, tID)
  expect_is(img, "array")
})

test_that("canGetScreenshotImageThumbnail", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  img <- getScreenshotImage(WPT, tID, thumbnail = TRUE)
  expect_is(img, "array")
})

test_that("canSaveScreenshot", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  tmpFile <- tempfile(fileext = ".png")
  img <- getScreenshotImage(WPT, tID, thumbnail = TRUE, file = tmpFile)
  # png 8 bit sig
  # https://en.wikipedia.org/wiki/Portable_Network_Graphics#File_header
  pngSig <- as.raw(c(0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a))
  imgSig <- readBin(tmpFile, "raw", n = 8)
  expect_identical(imgSig, pngSig)
})

test_that("canGetScreenshotImageDryRun", {
  WPT <- server()
  img <- getScreenshotImage(WPT, testId = "someId", run = 2L, 
                           repeatView = TRUE, thumbnail = TRUE, 
                           fullResolution = TRUE, startRender = TRUE, 
                           documentComplete = TRUE,
                           dryRun = TRUE)
  testDR <- paste0(WPT[["url"]], "/thumbnail.php?test=someId&run=2",
                   "&cached=1&file=2_Cached_screen_render.jpg")
  expect_identical(img, testDR)
})
