#!/usr/bin/perl
use warnings;
use strict;
use Digest::MD5 qw(md5 md5_hex md5_base64);

my $input = "wtnhxymk";
my @code = '';
my $c = 0;
my $cLen = 0;
my $filled_positions;
while($cLen<9){
	my $full_code = "$input$c";
	my $hex_input = md5_hex($full_code);
	if ($hex_input =~ /^0{5}(.)(.).*/){
		my $pos = $1;
		my $index = $2;
		if($pos=~/[0-7]{1}/){
			if(!$code[$pos]){
				$code[$pos]=$index;
				$cLen++;
				print "position: $pos, value: $index\n";
			}
		}
	}
	$c++;
}
print "@code\n";
print "$c\n";
