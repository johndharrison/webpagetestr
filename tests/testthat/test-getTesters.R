context("getTesters")

test_that("canGetTesters", {
  WPT <- server()
  testers <- getTesters(WPT)  
  expect_s3_class(testers, "testers")
})

test_that("canGetErrorFromGetTesters", {
  WPT <- server()
  with_mock(
    `httr::POST` = function(...){
      list(statusCode = 400,
           statusText = "Some testers error")},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x){x},
    expect_error(
      locs <- getTesters(WPT), "Server returned a statusCode = 400"   
    )
  )
})

test_that("canDryRunGetTesters", {
  WPT <- server()
  dr <- getTesters(WPT, "wwww", dryrun = TRUE)
  expect_identical(dr, paste0(WPT$url, "/getTesters.php?r=wwww&f=json"))
})
