#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open input";
open my $ofh, ">", "output.csv" or die "cannot open input";
my $bad=0;
my @trig1;
my @trig2;
my @trig3;
my $c=0;

while (<$fh>){
	chomp $_;
	my $line = $_;
	$line =~ s/ +/,/g;
	my @array = split(",",$line);
	shift(@array);
	$trig1[$c]=$array[0];
	$trig2[$c]=$array[1];
	$trig3[$c]=$array[2];
	if ($c==2){
		my @s1 = sort { $a <=> $b } @trig1;
		my @s2 = sort { $a <=> $b } @trig2;
		my @s3 = sort { $a <=> $b } @trig3;
		my $small_sides1 = $s1[0]+$s1[1];
		my $small_sides2 = $s2[0]+$s2[1];
		my $small_sides3 = $s3[0]+$s3[1];
		my $big_sides1 = $s1[2];
		my $big_sides2 = $s2[2];
		my $big_sides3 = $s3[2];

		if ($small_sides1>$big_sides1){
			$bad++;
		}
		if ($small_sides2>$big_sides2){
			$bad++;
		}
		if ($small_sides3>$big_sides3){
			$bad++;
		}
		$c= -1;
		my @trig1;
		print @trig1;
		my @trig2;
		my @trig3;
	}
	$c++;
}
print $bad;