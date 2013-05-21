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
import dbm.ndbm

if len(sys.argv) != 3:
	sys.exit(1)

command = sys.argv[1]
user = sys.argv[2]

db = dbm.open('db-karma', 'c')
if command == 'add':
	db[user] = str(int(db.get(user,0)) + 1)
	print('%s now has %s karma!' % (user,int(db[user])))
elif command == 'del':
	db[user] = str(int(db.get(user,0)) - 1)
	print('%s now has %s karma!' % (user,int(db[user])))
elif command == 'get':
	print('%s has %s karma!' % (user,int(db.get(user,0))))
else:
	print('what the karma')
	sys.exit(1)