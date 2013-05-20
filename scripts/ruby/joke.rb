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

uri = URI.parse("http://api.icndb.com/jokes/random")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
if response.code == "200"
	json = JSON.parse(response.body)
	print json['value']['joke']
else
	print 'error'
end