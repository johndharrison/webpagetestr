is_server <- function(x) {
  inherits(x, "WPTserver")
}

assertthat::on_failure(is_server) <-  function(call, env) {
  paste0(env$x, " is not a WPTserver")
}

is_string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

assertthat::on_failure(is_string) <-  function(call, env) {
  paste0(env$x, " is not a string")
}

is_string_or_null <- function(x) {
  is_string(x) || is.null(x)
}

assertthat::on_failure(is_string_or_null) <-  function(call, env) {
  paste0(env$x, " is not a string or null")
}

is_logical <- function(x){
  is.logical(x)
}

assertthat::on_failure(is_logical) <-  function(call, env) {
  paste0(env$x, " is not of type logical")
}

is_integer_or_null <- function(x) {
  is.integer(x) || is.null(x)
}

assertthat::on_failure(is_integer_or_null) <-  function(call, env) {
  paste0(env$x, " is not an integer or null")
}

is_integer <- function(x) {
  is.integer(x)
}

assertthat::on_failure(is_integer) <-  function(call, env) {
  paste0(env$x, " is not an integer")
}

is_writeable_path <- function(x){
  is_string(x) && file.access(dirname(x), 2) == 0L &&
    dir.exists(dirname(x))
}

assertthat::on_failure(is_writeable_path) <-  function(call, env) {
  paste0(env$x, " is not a writeable file/path")
}

is_character <- function(x) {
  is.character(x) && !any(is.na(x))
}

assertthat::on_failure(is_character) <-  function(call, env) {
  paste0(env$x, " is not a character vector")
}

is_character_or_null <- function(x) {
  is_character(x) || is.null(x)
}

assertthat::on_failure(is_character_or_null) <-  function(call, env) {
  paste0(env$x, " is not a character vector or NULL")
}

