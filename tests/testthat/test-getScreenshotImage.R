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
  tmpFile <- tempfile(fileext = ".jpg")
  img <- getScreenshotImage(WPT, tID, thumbnail = TRUE, file = tmpFile)
  # https://en.wikipedia.org/wiki/JPEG#Syntax_and_structure
  jpgSig <- as.raw(c(0xff, 0xd8, 0xff, 0xe0))
  imgSig <- readBin(tmpFile, "raw", n = 4)
  expect_identical(imgSig, jpgSig)
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

test_that("canGetScreenshotImageDryRunDocumentComplete", {
  WPT <- server()
  img <- getScreenshotImage(WPT, testId = "someId", run = 2L, 
                            repeatView = TRUE, thumbnail = TRUE, 
                            fullResolution = TRUE, documentComplete = TRUE,
                            dryRun = TRUE)
  testDR <- paste0(WPT[["url"]], "/thumbnail.php?test=someId&run=2",
                   "&cached=1&file=2_Cached_screen_doc.jpg")
  expect_identical(img, testDR)
})

test_that("canGetScreenshotImageDryRunFullResolution", {
  WPT <- server()
  img <- getScreenshotImage(WPT, testId = "someId", run = 2L, 
                            repeatView = TRUE, thumbnail = TRUE, 
                            fullResolution = TRUE, dryRun = TRUE)
  testDR <- paste0(WPT[["url"]], "/thumbnail.php?test=someId&run=2",
                   "&cached=1&file=2_Cached_screen.png")
  expect_identical(img, testDR)
})
