#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open input: $!";
my $checkSum = 0;
my %alphabet = (
				"a" => 1,
				"b" => 2,
				"c" => 3,
				"d" => 4,
				"e" => 5,
				"f" => 6,
				"g" => 7,
				"h" => 8,
				"i" => 9,
				"j" => 10,
				"k" => 11,
				"l" => 12,
				"m" => 13,
				"n" => 14,
				"o" => 15,
				"p" => 16,
				"q" => 17,
				"r" => 18,
				"s" => 19,
				"t" => 20,
				"u" => 21,
				"v" => 22,
				"w" => 23,
				"x" => 24,
				"y" => 25,
				"z" => 26,
			};
my %rAlphabet = reverse %alphabet;
while(<$fh>){
	my %letterHash;
	if (/(.+)-([0-9]+)\[(.+)\]/){
		my $string = $1;
		my $num = $2;
		my $check = $3;
		$string =~ s/-/ /g;
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
				# print "$finalstring\n";
			}
			$count++;
		}

		if($finalstring eq $check){
			my $realName;
			foreach my $nameChar (@chars){
				if ($nameChar != ' '){
					my $int = $alphabet{$nameChar};
					my $netInt = ($int + $num)%26;
					my $newChar = $rAlphabet{$newInt};
					$realName = "$realName$newChar";
				}else{
					$realName = "$realName ";
				}
			}
			print "$realName\n";
		}
	}

	# $string = s/-//g;
	# my @letters = split("", $string);
	# print "$checkSum\n";
}