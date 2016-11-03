\dontrun{
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(out[dim(out)[1], "Test ID"])
  har <- getHARData(WPT, tID)
}
