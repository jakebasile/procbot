#!/usr/bin/env node

if (process.argv.length != 4) {
	console.log('ERROR: Invalid params');
	return;
}
console.log(process.argv[2 + Math.floor(Math.random() * 2)])
