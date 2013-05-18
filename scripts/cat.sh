#!/usr/bin/env sh
curl -sL 'http://reddit.com/r/cats.json?limit=25' |\
    grep -Eo '"url": ?"([^"]*\.(jpg|jpeg|png|gif))"' |\
    sed -E 's/.*(http.*)"/\1/' | shuf | head -n 1
