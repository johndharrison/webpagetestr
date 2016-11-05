\dontrun{
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  screenshot <- getScreenshotImage(WPT, tID)
}
