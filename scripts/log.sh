#!/usr/bin/env sh

touch logs/"$1"
echo "$2" |\
    cat logs/"$1" - |\
    tail -n 10 - > logs/"$1.tmp"
mv logs/"$1.tmp" logs/"$1"
