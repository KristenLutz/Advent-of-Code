#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open file: $!";
my $total_length = 0;
my @ms = (
	{
	match => "(1x4)",
	length => "1",
	rep => "1",
	position => "pos",
	m => '0',
	},
);
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
shift @ms;
foreach my $t (0 .. scalar @ms -1){
	my $endOfMatch = $ms[$t]{position}+$ms[$t]{length};
	# print "$ms[$t]{match}, $endOfMatch\n";
	foreach my $k (0 .. scalar @ms -1){
		print "$endOfMatch, $ms[$k]{position}\n";
		if($k>$t){
			if ($endOfMatch >= $ms[$k]{position}){
				$ms[$k]{m}=$ms[$k]{m}*$ms[$t]{rep}*$ms[$t]{m};
			# print "true\n";
			}
		}	
	}
	my $strLen = $ms[$t]{length} * $ms[$t]{rep};
	if (($ms[$t]{position}+$ms[$t]{length}) > $total_length){
		$strLen = ($total_length - $ms[$t]{position})*$ms[$t]{rep};
		# print "applicable\n";
	}
	$total_length = $total_length - (length($ms[$t]{match})*$ms[$t]{rep}) + ($strLen * $ms[$t]{m});
	print "$total_length\n";
}
print "$total_length\n";
