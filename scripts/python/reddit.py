#!/usr/bin/env python3
# Copyright 2012-2013 Jake Basile and Kyle Varga
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

'''Shows a random image from a subreddit'''

import urllib.request
import urllib.parse
import random
import sys
import json
import re

if len(sys.argv) < 2:
    sys.exit(1)

subreddit = sys.argv[1]
timeframe = sys.argv[2] if len(sys.argv) > 2 else 'day'
sort = sys.argv[3] if len(sys.argv) > 3 else 'top'
filetypes = sys.argv[4] if len(sys.argv) > 4 else 'jpg|jpeg|gif|png'
regex = '^.*\.(%s)$' % filetypes
results = urllib.request.urlopen('http://reddit.com/r/%s.json?limit=100&t=%s&sort=%s' % (subreddit, timeframe, sort))
if results.status != 200:
	sys.exit(1)

jsn = json.loads(results.read().decode('utf-8'))

images = [
    str(c['data']['url'])
    for c in jsn['data']['children']
    if re.match(regex, c['data']['url']) and c['data']['over_18'] == False
]
print(random.choice(images))