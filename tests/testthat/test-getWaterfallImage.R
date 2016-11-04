context("getWaterFallImage")

test_that("canGetWaterfallImage", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  img <- getWaterfallImage(WPT, tID)
  expect_is(img, "array")
})

test_that("canGetWaterfallImageThumbnail", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  img <- getWaterfallImage(WPT, tID, thumbnail = TRUE)
  expect_is(img, "array")
})

test_that("canSaveWaterfall", {
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  tmpFile <- tempfile(fileext = ".png")
  img <- getWaterfallImage(WPT, tID, thumbnail = TRUE, file = tmpFile)
  # png 8 bit sig
  # https://en.wikipedia.org/wiki/Portable_Network_Graphics#File_header
  pngSig <- as.raw(c(0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a))
  imgSig <- readBin(tmpFile, "raw", n = 8)
  expect_identical(imgSig, pngSig)
})

test_that("canGetWaterfallImageDryRun", {
  WPT <- server()
  img <- getWaterfallImage(WPT, testId = "someId", run = 2L, 
                           repeatView = TRUE, thumbnail = TRUE, 
                           chartType = "connection", colorByMime = TRUE, 
                           chartWidth = 780L, wrequests = "1,7",
                           maxTime = 20L, noCPU = TRUE, noBandwidth = TRUE,
                           noEllipsis = TRUE, noLabels = TRUE, 
                           dryRun = TRUE)
  testDR <- paste0(WPT[["url"]], "/thumbnail.php?test=someId&run=2",
                   "&cached=1&type=connection&mime=1&width=780", 
                   "&max=20&requests=1%2C7&cpu=0&bw=0&dots=0", 
                   "&labels=0&file=2_Cached_waterfall.png")
  expect_identical(img, testDR)
})
