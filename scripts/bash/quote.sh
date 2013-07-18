#!/usr/bin/env bash

if [[ $1 == 'remember' ]]
    then
        grep -Ei "$3" logs/"$2" >> quotes/"$2"
fi

if [[ $1 == 'quote' ]]
    then
        results=$(grep -Ei "$3" quotes/"$2")
        if [[ $4 == 'cow' ]]
            then
                echo "$2 said:"
                cowsay $results
        else
                echo "$2 said: $results"
        fi
fi

if [[ $1 == 'quotemash' ]]
    then
        results=$(cat "quotes/*" | shuf -n 5 )
        echo "$results"
    fi
fi

