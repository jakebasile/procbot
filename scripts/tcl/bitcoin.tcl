#!/usr/bin/env tclsh

# Copyright 2013 Kyle Varga
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
