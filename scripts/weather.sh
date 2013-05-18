#!/usr/bin/env sh

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

if [ ! $1 ]
then
	echo 'no key passed'
	exit
fi
location='US/TX/Austin'
if [ $2 ]
then
	location=$2
fi

url="http://api.wunderground.com/api/$1/geolookup/conditions/q/$location.json"
printf "url is %s\n" "$url"
weather=$(curl -Ls $url|\
	grep 'temp_f' |\
	tr -dc '[0-9.]'\
)

printf "Current Temperature in %s is %s°" "$location" "$weather"
