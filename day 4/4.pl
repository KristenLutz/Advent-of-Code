#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open input: $!";
my $checkSum = 0;

while(<$fh>){
	my %letterHash;
	if (/(.+)-([0-9]+)\[(.+)\]/){
		my $string = $1;
		my $num = $2;
		my $check = $3;
		$string =~ s/-//g;
		my @chars = split('',$string);
		foreach my $c (@chars){
			if ($letterHash{$c}){
				$letterHash{$c}++;
			}else{
				$letterHash{$c}=1;
			}
		}
		my $finalstring ='';
		my $count = 0;
		foreach my $letter (sort{$letterHash{$b} <=> $letterHash{$a} or $a cmp $b} keys %letterHash){
			if ($count < 5){
				$finalstring = "$finalstring$letter";
				print "$finalstring\n";
			}
			$count++;
		}

		if($finalstring eq $check){
			print "$finalstring:$check\n";
			$checkSum = $checkSum + $num;
		}
	}

	# $string = s/-//g;
	# my @letters = split("", $string);
	print "$checkSum\n";
}