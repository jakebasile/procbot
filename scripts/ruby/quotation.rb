#!/usr/bin/env ruby

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
