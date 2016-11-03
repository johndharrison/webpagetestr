\dontrun{
  WPT <- server()
  history <- getHistory(WPT, filter = "London")
  tID <- as.character(history[dim(history)[1], "Test ID"])
  testresults <- getTestResults(WPT, tID, requestId = "someID")
}
