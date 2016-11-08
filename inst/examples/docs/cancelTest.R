\dontrun{
  WPT <- server()
  locs <- getLocations(WPT)
  
  lMax <- which.max(vapply(locs, 
                           function(x) x$PendingTests$Total, integer(1)))
  maxLoc <-locs[[lMax]]
  test <- runTest(WPT, "r-project.org", 
                  location = paste0(maxLoc$location,
                                    ":Chrome"))
  cTest <- cancelTest(WPT, test$testId)
  cTest <- cancelTest(WPT, test$testId, dryRun = TRUE)
  expect_identical(cTest, paste0(WPT$url, "/cancelTest.php?test=", 
                                 test$testId, "&k=", 
                                 Sys.getenv("WPTKEY"), "&f=json"))
}
