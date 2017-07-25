#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "can't open input: $1";

my $y= "." x 50;
my @box = ($y) x 6;
# foreach my $x (@box){
# 	print "$x\n";
# }
while (<$fh>){
	my $len = scalar @box;
	if(/rect ([0-9]{1,2})x([0-9]{1,2})/){
		foreach my $c (0..$2-1){
			my $r = "#" x $1;
			substr($box[$c],0,$1,$r);
		}
	}elsif(/rotate (column x|row y)=([0-9]{1,2}) by ([0-9]{1,2})/){
		my $coord = $2;
		my $offset = $3;
		if($1 eq "column x"){
			my @old_box = @box;
			foreach my $c2 (0..$len-1){
				my $row = $c2-$offset;
				if($row<0){
					$row = $row+$len;
				}
				my $new_row = "$old_box[$row]\n";
				my $new_char = substr($new_row,$coord,1);
				substr($box[$c2],$coord,1,$new_char); 
			}
		}else{
			my @rowArray = split('',$box[$coord]);
			foreach my $i (0..$offset-1){
				my $value = pop @rowArray;
				unshift @rowArray, $value;
			}
			$box[$coord] = join('',@rowArray);
		}
	}else{
		print "unexpected input\n";
		print "$_";
	}
}
my $count = 0;
foreach my $z (@box){
	print "$z\n";
	foreach my $countchar (split('',$z)){
		if($countchar eq "#"){
			$count++;
		}
	}
}
print $count;
 