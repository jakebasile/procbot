#!/usr/bin/env perl

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
