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
# Script is from http://www.cyberciti.biz/faq/howto-pass-perl-command-line-arguments/
#

if ( $#ARGV != 2 ) {
	print "ERROR: Incorrect number of arguments";
	exit;
}
$n1=$ARGV[0];
$op=$ARGV[1];
$n2=$ARGV[2];
$ans=0;
if ( $op eq "+" ) {
	$ans = $n1 + $n2;
}
elsif ( $op eq "-"){
	$ans = $n1 - $n2;
}
elsif ( $op eq "/"){
	$ans = $n1 / $n2;
}
elsif ( $op eq "*"){
	$ans = $n1 * $n2;
}
else {
	print "Error: op must be +, -, *, / only\n";
	exit;
}
print "$ans\n";