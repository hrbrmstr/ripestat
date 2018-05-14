.get_dns_chain <- function(host_or_ip) {

  if (length(host_or_ip) > 1) {
    warning("host_or_ip length > 1; Using first element.")
    host_or_ip <- host_or_ip[1]
  }

  host_or_ip <- trimws(toupper(host_or_ip))

  httr::GET(
    url = "https://stat.ripe.net/data/dns-chain/data.json",
    query = list(
      resource = host_or_ip
    ),
    httr::user_agent(RIPESTAT_PACKAGE_USER_AGENT)
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out

}

#' DNS Chain
#'
#' This data call returns the recursive chain of DNS forward (A/AAAA/CNAME) and
#' reverse (PTR) records starting form either a hostname or an IP address.
#'
#' @md
#' @param host_or_ip Hostname or IP address (Ipv4 or IPv6)
#' @export
#' @examples \dontrun{
#' get_dns_chain("r-project.org")
#' }
get_dns_chain <- memoise::memoise(.get_dns_chain)
