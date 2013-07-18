#!/usr/bin/env python3

import sys
import dbm.ndbm

if len(sys.argv) != 3:
	sys.exit(1)

command = sys.argv[1]
user = sys.argv[2].lower()

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
