context("getLocations")

test_that("canGetLocations", {
  WPT <- server()
  locs <- getLocations(WPT)  
  expect_s3_class(locs, "locations")
})

test_that("canGetErrorFromGetLocations", {
  WPT <- server()
  with_mock(
    `httr::POST` = function(...){
      list(statusCode = 400,
           statusText = "Some location error")},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_error(
      locs <- getLocations(WPT), "Server returned a statusCode = 400"   
    )
  )
})