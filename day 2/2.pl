#!/usr/bin/perl
use warnings;
use strict;

#advent of code, day 2

open my $fh, "<", "input.csv" or die "cannot open input";
open my $ofh, ">", "output.csv" or die "cannot open output";
my @numPad;
@numPad = (
			['','','1','',''],
			['','2','3','4',''],
			['5','6','7','8','9'],
			['','A','B','C',''],
			['','','D','',''],
		);
my $x = 0;
my $y = 2;

print $numPad[$y][$x];
my $code="";

while (<$fh>){
 	chomp $_;
 	foreach my $char (split('',$_)){
		if($char eq "D"){
			if ($y+1<=4&&$numPad[$y+1][$x]){
				$y++;
			}
		} elsif($char eq "U"){
			if ($y-1>=0&&$numPad[$y-1][$x]){
				$y--;
			}
		} elsif($char eq "R"){
			if ($x+1<=4&&$numPad[$y][$x+1]){
				$x++;
			}
		} elsif($char eq "L"){
			if ($x-1>=0&&$numPad[$y][$x-1]){
				$x--;
			}
		}
		print "x: $x y: $y code: $numPad[$y][$x] move:$char\n";
	}
	$code = "$code$numPad[$y][$x]";
}
print $code;
