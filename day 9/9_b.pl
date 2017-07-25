#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open file: $!";
my $total_length=0;
while (<$fh>){
	my $new_string;
	my $pos = 0;
	if(m/(\((([0-9]{1,2})x([0-9]{1,2}))\))/$1/ge){
		print "$1, $2, $3, $4\n";
		if(s/\G(.{$3})/$1x$4/e){
			print $_;
		}
	}
}
# 		my $len = $2;
# 		my $rep = $3;
# 		my $match = $1;
# 		my $str = $4;
# 		print $_, "\n";
# 		print pos($_), "\n";
# 		my $old_str = substr($str,0,$len);
# 		my $new_str = $old_str x $rep;
# 		# print $old_str,"\n", $new_str, "\n";
# 		# print pos($_), "\n";
# 		$_ =~ s/(\($match\))(.{1,$len})/$1$new_str/;
		
# 		# print $_, "\n";
# 		# print pos($_), "\n";
# 		pos($_)= @+ + $len*$rep;
# 	}
# 	$total_length = $total_length + length($_);
# 	print $_;
# }

# print $total_length;
