#!/usr/bin/env ruby

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

require "net/http"
require "uri"

require "rubygems"
require "json"
sources = [
#	"esrhumorix_misc",
	"joel_on_software",
	"macintosh",
	"math",
#	"mav_flame",
#	"osp_rules",
	"paul_graham",
	"prog_style",
	"subversion",
#	"1811_dictionary_of_the_vulgar_tongue",
	"codehappy",
#	"fortune",
#	"liberty",
	"literature",
	"misc",
#	"murphy",
	"oneliners",
	"riddles",
#	"rkba",
#	"shlomif",
#	"shlomif_fav",
#	"stephen_wright",
	"calvin",
#	"forrestgump",
#	"friends",
	"futurama",
#	"holygrail",
#	"powerpuff",
#	"simon_garfunkel",
#	"simpsons_cbg",
#	"simpsons_chalkboard",
#	"simpsons_homer",
#	"simpsons_ralph",
	"south_park",
	"starwars",
#	"xfiles",
#	"bible",
#	"contentions",
#	"osho",
#	"cryptonomicon",
#	"discworld",
#	"dune",
#	"hitchhiker",
]
uri = URI.parse("http://www.iheartquotes.com/api/v1/random?format=json&source=" + sources.join('+'))
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
if response.code == "200" and not response.body.nil?
	json = JSON.parse(response.body)
	print json['quote']
else
	print 'error'
end