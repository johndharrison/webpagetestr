is_server <- function(x) {
  inherits(x, "WPTserver")
}

assertthat::on_failure(is_server) <-  function(call, env) {
  paste0(sub("caArgs\\$", "", deparse(call$x)), " is not a WPTserver")
}

is_string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

assertthat::on_failure(is_string) <-  function(call, env) {
  paste0(sub("caArgs\\$", "", deparse(call$x)), " is not a string")
}

is_string_or_null <- function(x) {
  is_string(x) || is.null(x)
}

assertthat::on_failure(is_string_or_null) <-  function(call, env) {
  paste0(sub("caArgs\\$", "", deparse(call$x)), " is not a string or null")
}

is_logical <- function(x){
  is.logical(x)
}

assertthat::on_failure(is_logical) <-  function(call, env) {
  paste0(sub("caArgs\\$", "", deparse(call$x)), " is not of type logical")
}

is_integer_or_null <- function(x) {
  is.integer(x) || is.null(x)
}

assertthat::on_failure(is_integer_or_null) <-  function(call, env) {
  paste0(sub("caArgs\\$", "", deparse(call$x)), " is not an integer or null")
}

is_integer <- function(x) {
  is.integer(x)
}

assertthat::on_failure(is_integer) <-  function(call, env) {
  paste0(sub("caArgs\\$", "", deparse(call$x)), " is not an integer")
}
