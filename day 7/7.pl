#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "can't open input: $!";
my $count = 0;

while(<$fh>){
	my $line = $_;
	my $b = 0;
	my (@char1, @char2);
	foreach ($line=~m/\[(.*?)\]/g){
		my @supernet = split(/\[.*?\]/, $line);
		while (/(?=([a-z])([a-z])\g1)/g && $1 ne $2){
			my ($c1, $c2) = ($1, $2);
			foreach my $t (@supernet){
				if ($t=~ m/($c2$c1$c2)/g){$b=1;}
			}
		}
	}
	if($b){$count++;}
}
print "$count\n";