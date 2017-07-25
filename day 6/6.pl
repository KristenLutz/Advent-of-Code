#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "can't open input: $!";

my @charCount = (
			{
				a => 0
			},
			{
				a => 0
			},
		);
while (<$fh>){
	chomp $_;
	my @line = split('',$_);
	foreach my $c (0..scalar(@line)-1){
		if($charCount[$c]{$line[$c]}){
			$charCount[$c]{$line[$c]}++;
		}else{
			$charCount[$c]{$line[$c]}=1;
		}
	}
}
foreach my $c2 (0 .. scalar(@charCount-1)){
	my $c3 = 0;
	foreach my $key (sort{$charCount[$c2]{$a} <=> $charCount[$c2]{$b} or $a cmp $b} keys $charCount[$c2]){
		if ($c3<1){
			print "$key";
			$c3++;
		}
	}
	# foreach my $letter (sort{$charCount{$b} <=> $charCount{$a} or $a cmp $b} keys %charCount[$c2]){
	# 	print $letter;
	# }
}