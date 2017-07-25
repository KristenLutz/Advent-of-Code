#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open file: $!";
my $total_length = 0;
my @ms;
while (<$fh>){
	chomp $_;
	$total_length = length ($_);
	while(/(\(([0-9]{1,5})x([0-9]{1,5})\))(?=(.*))/g){
		my $len = $2;
		my $rep = $3;
		my $match = $1;
		#$+[1] is a variable containing the ending position of the first match
		push @ms, {match => $match,length =>$len,rep=>$rep, position => $+[1], m=> "1"};
	}
}

foreach my $t (0 .. scalar @ms -1){
	# print "$ms[$t]{match}\n";
	# print "$total_length, ", length($ms[$t]{match}),", ", $ms[$t]{length}*$ms[$t]{rep}, "\n";
	# print "$ms[$t]{m}\n";
	my $added = ($ms[$t]{length}*$ms[$t]{rep})*$ms[$t]{m};
	my $sub = (length($ms[$t]{match}) + $ms[$t]{length})*$ms[$t]{m};
	$total_length = $total_length + $added - $sub;
	foreach my $k (0 .. scalar @ms -1){
		if($k>$t){
			if($ms[$t]{position}+$ms[$t]{length}>=$ms[$k]{position}){
				$ms[$k]{m}=$ms[$k]{m}*$ms[$t]{rep};
			}
		}
	}
	# print "$total_length\n";
}
print "$total_length\n";
