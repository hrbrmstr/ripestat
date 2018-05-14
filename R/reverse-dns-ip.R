.reverse_dns_ip <- function(ip) {

  if (length(ip) > 1) {
    warning("ip length > 1; Using first element.")
    ip <- ip[1]
  }

  ip <- trimws(ip)

  httr::GET(
    url = "https://stat.ripe.net/data/reverse-dns-ip/data.json",
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

#' Reverse DNS IP
#'
#' Simple lookup for the reverse DNS info against a single IP address.
#'
#' @md
#' @param ip IP address for the query.
#' @export
#' @examples \dontrun{
#' reverse_dns_ip("193.0.6.139")
#' }
reverse_dns_ip <- memoise::memoise(.reverse_dns_ip)
