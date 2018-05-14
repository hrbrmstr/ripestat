.get_country_resource_list <- function(iso2c, time=NULL, v4_format=NULL) {

  if (length(iso2c) > 1) {
    warning("iso2c length > 1; Using first element.")
    iso2c <- iso2c[1]
  }

  if (!is.null(time)) {
    time <- parsedate::format_iso_8601(parsedate::parse_iso_8601(time))
    if (is.na(time)) stop("'time' must be a valid R date/time object or a valid ISO-8601 time string.", call.=FALSE)
  }

  if (!is.null(v4_format)) {
    if (!(v4_format %in% c("", "prefix"))) {
      stop("v4_format must be NULL, an empty string ('') or 'prefix'.", call.=FALSE)
    }
  }

  httr::GET(
    url = "https://stat.ripe.net/data/country-resource-list/data.json",
    query = list(
      resource = iso2c,
      time = time,
      v4_format = v4_format
    ),
    httr::user_agent(RIPESTAT_PACKAGE_USER_AGENT)
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out

}

#' Country Resource List
#'
#' This data call lists the Internet resources associated with a country, including
#' ASNs, IPv4 ranges and IPv4/6 CIDR prefixes.
#'
#' @md
#' @param iso2c The country to find IP prefixes and AS numbers for. (2-digit ISO-3166
#'        country code - See <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2> for details.)
#' @param time The time to query. By default (`NULL`), returns the latest available data.
#'        (ISO-8601 or Unix timestamp)
#' @param v4_format format parameter; when not `NULL`, possible values: `""` or `"prefix"`.
#'        `"prefix"` will return each entry in prefix notation, meaning that ranges are
#'        converted to CIDR prefixes.
#' @export
#' @examples \dontrun{
#' get_country_resource_list("MX")
#' }
get_country_resource_list <- memoise::memoise(.get_country_resource_list)
