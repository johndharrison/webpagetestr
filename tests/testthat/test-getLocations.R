context("getLocations")

test_that("canGetLocations", {
  WPT <- server()
  locs <- getLocations(WPT)  
  expect_s3_class(locs, "locations")
})

test_that("errorOnInvalidRequestIdGetLocations", {
  WPT <- server()
  expect_error(getLocations(WPT, 1), "requestId is not a string or null")
})

test_that("canGetErrorFromGetLocations", {
  WPT <- server()
  with_mock(
    `httr::POST` = function(...){
      list(statusCode = 400L,
           statusText = "Some location error")},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_error(
      locs <- getLocations(WPT), "Server returned a statusCode = 400"   
    )
  )
})

test_that("canDryRunGetLocations", {
  WPT <- server()
  dr <- getLocations(WPT, "wwww", dryRun = TRUE)
  expect_identical(dr, paste0(WPT[["url"]], 
                         "/getLocations.php?r=wwww&k=", 
                         Sys.getenv("WPTKEY"), "&f=json"))
})
