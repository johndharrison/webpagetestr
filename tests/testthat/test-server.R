context("server")

test_that("canCallServer",{
  srv <- server()
  expect_s3_class(srv, "WPTserver")
})
