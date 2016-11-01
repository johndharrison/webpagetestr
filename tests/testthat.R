library(testthat)
library(webpagetestr)

if(Sys.getenv("NOT_CRAN") == "true"){
  test_check("webpagetestr")
}