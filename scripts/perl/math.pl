#!/usr/bin/env perl

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

#
# Original script modified from http://www.cyberciti.biz/faq/howto-pass-perl-command-line-arguments/
#


if ( $#ARGV != 2 ) {
	print "ERROR: Incorrect number of arguments";
	exit;
}

$left = $ARGV[0];
$operator = $ARGV[1];
$right = $ARGV[2];
$answer = 0;

if ( $operator eq "+" ) {
	$answer = $left + $right;
}
elsif ( $operator eq "-"){
	$answer = $left - $right;
}
elsif ( $operator eq "/"){
	$answer = $left / $right;
}
elsif ( $operator eq "*"){
	$answer = $left * $right;
}
elsif ( $operator eq "%") {
	$answer = $left % $right;
}
elsif ( $operator eq "^") {
	$answer = $left ** $right;
}
else {
	print "Error: operator must be +, -, *, /, %, or ^";
	exit;
}
print "$answer";