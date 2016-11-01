context("getLocations")

test_that("canGetLocations", {
  WPT <- server()
  locs <- getLocations(WPT)  
  expect_s3_class(locs, "locations")
})
