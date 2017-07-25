my $new_str = "(1x3)A";
my $rep = 3;
$new_str = "$new_str"x$rep;
# $str =~ s/($str)/$1x3/ge;
print $new_str;