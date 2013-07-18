#!/usr/bin/env tclsh

package require http
package require tls
package require json
http::register https 443 tls::socket

set url [http::geturl https://data.mtgox.com/api/2/BTCUSD/money/ticker]

if {[http::status $url] == "ok"} {
   set data [http::data $url]
   set dict [json::json2dict $data]
   puts stdout [dict get [dict get [dict get $dict "data"] "last"] "display"]
} else {
   return 1
}
http::cleanup $url
