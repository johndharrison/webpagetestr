context("getResponseBody")

test_that("canGetResponseBodyDryRun", {
  WPT <- server()
  ResponseBody <- getResponseBody(WPT, testId = "atestid", run = 2L, 
                                  repeatView = TRUE, dryRun = TRUE)  
  expect_identical(
    ResponseBody, 
    paste0(WPT$url, 
           "/response_body.php?test=atestid&run=2&cached=1&request=1")
  )
})

test_that("canGetResponseBodyViaMock", {
  WPT <- server()
  with_mock(
    `httr::GET` = function(...){
      c("some text")},
    `httr::stop_for_status` = function(...){}, 
    `httr::content` = function(x, ...){x},
    expect_is(getResponseBody(WPT, "atestid"), "character")
  )
})

