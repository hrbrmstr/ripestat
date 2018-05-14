#' What's My IP?
#'
#' This data call returns the IP address of the requestor.
#'
#' @md
#' @export
whats_my_ip <- function() {
  jsonlite::fromJSON("https://stat.ripe.net/data/whats-my-ip/data.json")
}