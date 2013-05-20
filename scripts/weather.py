#!/usr/bin/env python3

# Copyright 2013 Jake Basile and Kyle Varga
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

import sys
import json
import urllib.request
import urllib.parse

if len(sys.argv) < 2:
    sys.exit(1)

key = sys.argv[1]
if len(sys.argv) < 3:
    location = "78701"
else:
    location = sys.argv[2]
url = "http://api.wunderground.com/api/" + key + "/geolookup/conditions/q/" + location + ".json"

results = urllib.request.urlopen(url)

if results.status != 200:
    sys.exit(1)

jsn = json.loads(results.read().decode('utf-8'))

if 'error' in jsn['response']:
    print("Error: " + jsn['response']['error']['description'])
    sys.exit(1)

tempf= jsn['current_observation']['temp_f']
img= jsn['current_observation']['icon_url']
weather= jsn['current_observation']['weather']
loc= jsn['current_observation']['observation_location']['full']

print("It is currently %s° (%s) in %s. %s" % (tempf, weather, loc, img))