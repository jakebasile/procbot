#!/usr/bin/env python3

# Copyright 2013 Jake Basile
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

if len(sys.argv) != 4:
    sys.exit(1)

key = sys.argv[1]
query = sys.argv[2]
location = sys.argv[3] 

query = urllib.parse.urlencode(
    [
        ('key', sys.argv[1]),
        ('query', sys.argv[2]),
        ('location', sys.argv[3]),
        ('radius', 850),
        ('sensor', 'false'),
        ('types', 'restaurant|food'),
        ('opennow', 'true'),
    ],
)

url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?' + query

results = urllib.request.urlopen(url)

if results.status != 200:
    sys.exit(1)

jsn = json.loads(results.read().decode('utf-8'))

places = [
    (p['name'], p['formatted_address'], p['rating'])
    for p in jsn['results']
    if 'rating' in p
]

good_places = sorted(places, reverse=True, key=lambda p: p[2])[:5]

print('\n'.join('{0} ({2}/5): {1}'.format(*place) for place in good_places))

