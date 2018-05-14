.get_network_info <- function(ip) {

  if (length(ip) > 1) {
    warning("ip length > 1; Using first element.")
    ip <- ip[1]
  }

  ip <- trimws(ip)

  httr::GET(
    url = "https://stat.ripe.net/data/network-info/data.json",
    query = list(
      resource = ip
    ),
    httr::user_agent(RIPESTAT_PACKAGE_USER_AGENT)
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out

}

#' Network Info
#'
#' This data call returns the containing prefix and announcing ASN of a given IP address.
#'
#' @md
#' @param ip Any IP address one wants to get network info for.
#' @export
#' @examples \dontrun{
#' get_network_info("140.78.90.50")
#' }
get_network_info <- memoise::memoise(.get_network_info)
