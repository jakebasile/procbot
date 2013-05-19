#!/usr/bin/env sh

# Copyright 2013 Jake Basile
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
