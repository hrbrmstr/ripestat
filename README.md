
# ripestat

Query and Retrieve Data from the ‘RIPEstat’ ‘API’

## Description

‘RIPEstat’ is a web-based interface that provides everything you ever
wanted to know about ‘IP’ address space, ‘Autonomous System Numbers’
(‘ASNs’), and related information for hostnames and countries in one
place. Methods are provides to query and retrieve data from the
‘RIPEstat’ ‘API’.

## What’s Inside The Tin

The following functions are implemented:

  - `get_announced_prefixes`: Announced Prefixes
  - `get_country_resource_list`: Country Resource List
  - `get_dns_chain`: DNS Chain
  - `get_network_info`: Network Info
  - `reverse_dns_ip`: Reverse DNS IP
  - `whats_my_ip`: What’s My IP?

## Installation

``` r
devtools::install_github("hrbrmstr/ripestat")
```

## Usage

``` r
library(ripestat)

# current verison
packageVersion("ripestat")
```

    ## [1] '0.1.0'

### Announced Prefixes

``` r
str(get_announced_prefixes("AS3333")$data, 2)
```

    ## List of 6
    ##  $ resource       : chr "3333"
    ##  $ prefixes       :'data.frame': 8 obs. of  2 variables:
    ##   ..$ timelines:List of 8
    ##   ..$ prefix   : chr [1:8] "193.0.22.0/23" "193.0.10.0/23" "2001:67c:2e8::/48" "193.0.18.0/23" ...
    ##  $ query_starttime: chr "2018-04-30T00:00:00"
    ##  $ latest_time    : chr "2018-05-14T00:00:00"
    ##  $ query_endtime  : chr "2018-05-14T00:00:00"
    ##  $ earliest_time  : chr "2000-08-01T00:00:00"

### Country Resource List

``` r
str(get_country_resource_list("MX")$data, 2)
```

    ## List of 2
    ##  $ query_time: chr "2018-05-12T00:00:00"
    ##  $ resources :List of 3
    ##   ..$ ipv4: chr [1:1141] "45.5.52.0/22" "45.5.92.0/22" "45.6.60.0/22" "45.6.140.0/22" ...
    ##   ..$ asn : chr [1:372] "278" "1292" "1831" "1840" ...
    ##   ..$ ipv6: chr [1:169] "2001:448::/32" "2001:1200::/32" "2001:1208::/32" "2001:1210::/32" ...

### DNS Chain

``` r
str(get_dns_chain("r-project.org")$data, 2)
```

    ## List of 6
    ##  $ query_time               : chr "2018-05-14T03:20:00"
    ##  $ resource                 : chr "R-PROJECT.ORG"
    ##  $ reverse_nodes            :List of 1
    ##   ..$ 137.208.57.37: chr "cran.wu-wien.ac.at"
    ##  $ nameservers              : chr [1:3] "193.0.19.102" "193.0.19.103" "193.0.19.101"
    ##  $ authoritative_nameservers: chr [1:8] "ns10.univie.ac.at" "ns5.univie.ac.at" "ns2.wu-wien.ac.at" "ns3.urbanek.info" ...
    ##  $ forward_nodes            :List of 2
    ##   ..$ R-PROJECT.ORG     : chr "137.208.57.37"
    ##   ..$ cran.wu-wien.ac.at: chr "137.208.57.37"

### Network Info

``` r
str(get_network_info("140.78.90.50")$data, 2)
```

    ## List of 2
    ##  $ prefix: chr "140.78.0.0/16"
    ##  $ asns  : chr "1205"

### Reverse DNS IP

``` r
str(reverse_dns_ip("193.0.6.139")$data, 2)
```

    ## List of 4
    ##  $ query_time: chr "2018-05-14T03:33:00"
    ##  $ resource  : chr "193.0.6.139"
    ##  $ result    : chr "www.ripe.net"
    ##  $ error     : chr ""

### What’s My IP

``` r
whats_my_ip()
```
