.get_announced_prefixes <- function(asn, starttime=NULL, endtime=NULL, min_peers_seeing=3) {

  if (length(asn) > 1) {
    warning("asn length > 1; Using first element.")
    asn <- asn[1]
  }

  asn <- trimws(toupper(asn))

  if (!grepl("^AS", asn)) asn <- sprintf("AS%s", asn)

  if (!is.null(starttime)) {
    starttime <- parsedate::format_iso_8601(parsedate::parse_iso_8601(starttime))
    if (is.na(starttime)) stop("'starttime' must be a valid R date/time object or a valid ISO-8601 time string.", call.=FALSE)
  }

  if (!is.null(endtime)) {
    endtime <- parsedate::format_iso_8601(parsedate::parse_iso_8601(endtime))
    if (is.na(endtime)) stop("'endtime' must be a valid R date/time object or a valid ISO-8601 time string.", call.=FALSE)
  }

  httr::GET(
    url = "https://stat.ripe.net/data/announced-prefixes/data.json",
    query = list(
      resource = asn,
      starttime = starttime,
      endtime = endtime,
      min_peers_seeing = min_peers_seeing
    ),
    httr::user_agent(RIPESTAT_PACKAGE_USER_AGENT)
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(out)

  out

}

#' Announced Prefixes
#'
#' This data call returns all announced prefixes for a given ASN.
#' The results can be restricted to a specific time period.
#'
#' @md
#' @param asn The Autonomous System Number for which to return prefixes.
#'        Will auto-prefix with `AS` if just numeric.
#' @param starttime,endtime Start/end times for the query. When not `NULL` should be
#'        an ISO-8601 or Unix timestamp. If `starttime` is `NULL` the query defaults to two weeks
#'        before current date and time. If `endtime` is `NULL`, the query falls back to current date and time.
#' @param min_peers_seeing Minimum number of RIS peers seeing the prefix for it to be included in the results.
#'        Excludes low-visibility/localized announcements. Default: `3`.
#' @export
#' @examples \dontrun{
#' get_announced_prefixes("AS3333")
#' }
get_announced_prefixes <- memoise::memoise(.get_announced_prefixes)
