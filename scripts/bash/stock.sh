#!/usr/bin/env sh

price=$(curl -Ls "http://finance.yahoo.com/webservice/v1/symbols/$1/quote?format=xml" |\
    grep -E 'price' |\
    sed -E 's/<field name="price">(.+)<\/field>/\1/')
echo "$1 trading at $price."
