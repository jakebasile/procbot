#!/usr/bin/env sh

# If shuf or gshuf are not available, you must install them 
curl -sL 'http://www.reddit.com/r/dogpictures/top.json?sort=top&t=day' |\
    grep -Eo '"url": ?"([^"]*\.(jpg|jpeg|png|gif))"' |\
    sed -E 's/.*(http.*)"/\1/' |\
    if which shuf > /dev/null; then
        shuf "$@"
    elif which gshuf > /dev/null; then
        gshuf "$@"
    else
    	echo 'ERROR: Requires shuf or gshuf'
    fi|\
    head -n 1
