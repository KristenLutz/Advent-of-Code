#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open file: $!";
my $total_length=0;
while (<$fh>){
	my $new_string;
	my $pos = 0;
	while(/(\(([0-9]{1,5})x([0-9]{1,5})\))(?=(.*))/g){
		my $len = $2;
		my $rep = $3;
		my $match = $1;
		# print $_, "\n";
		print "$match\n";

		my $old_str = substr($_,pos($_),$len);
		my $new_str = $old_str x $rep;
		my $start = pos($_) - length($match);
		substr($_, $start,$len+length($match), $new_str);
		# pos($_)= $start + $len*$rep;
	}
	$total_length = $total_length + length($_);
	# print "$_\n";
	chomp($_);
	print "$_\n";
	print length($_), "\n"
}

print "$total_length\n";
