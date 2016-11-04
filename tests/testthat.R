library(testthat)
library(webpagetestr)
library(png)

if(Sys.getenv("NOT_CRAN") == "true"){
  test_check("webpagetestr")
}