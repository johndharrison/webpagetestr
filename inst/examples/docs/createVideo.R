\dontrun{
  WPT <- server()
  history <- getHistory(WPT, days = 10L, filter = "google.com")
  tests <- tail(history[["Test ID"]], 5)
  createVideo(WPT, tests = tests)
}
