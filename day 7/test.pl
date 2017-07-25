#!/usr/bin/perl
use strict;
use warnings;

$_ = "betalphabetabeta";

while (/(?=(alpha|beta))/g) {
    print $1, "\n"; 
}