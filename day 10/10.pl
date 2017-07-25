#!/usr/bin/perl
use warnings;
use strict;

open my $fh, "<", "input.csv" or die "cannot open file: $!";
open my $ofh, ">", "output.csv" or die "cannot open out file: $!";
my @output_bin;
my @bot;
my @value;
my @distribute;
my @active_bot;
my $bot_count = 0;
while (<$fh>){
	if(/value ([0-9]{1,4}) goes to bot ([0-9]{1,4})/){
		# print "value : $1, bot : $2\n";
		push @value, $_;
	}elsif(/bot ([0-9]{1,4}) gives (low|high) to (bot|output) ([0-9]{1,4}) and (low|high) to (output|bot) ([0-9]{1,4})/){
		push @{ $distribute[$1] }, $_;
	}else{
		print "ERROR 1\n";
	}
}
my @sorted_values = sort { ($a =~ /(\d+$)/)[0] <=> ($b =~ /(\d+$)/)[0] } @value;

# my $bot_count = 0;
foreach my $v (@sorted_values){
	print $ofh "$v\n";

	if($v =~ /value ([0-9]{1,4}) goes to bot ([0-9]{1,4})/){
		push @{ $bot[$2] }, $1;
		if($bot[$2][1]){
			push @active_bot, $2;
			$bot_count++;
		}
	}else{
		print "ERROR 2\n";
	}
	# print @active_bot;
	while($bot_count > 0){
		# my $full_bot_count = 0;
		
		while (scalar @active_bot>0){
			foreach my $botnum (@active_bot){
				@{ $bot[$active_bot[0]] } = sort {$a <=> $b} @{ $bot[$active_bot[0]] };
				print $ofh "full bots: @active_bot\n";
				print $ofh "bot $active_bot[0] is now holding ", $bot[$active_bot[0]][0], " and ",$bot[$active_bot[0]][1], "\n";
				# if ($bot[$botnum][0]==17){
				# 	print "$botnum is the bot\n";
				# }

				my $line = shift @{ $distribute[$active_bot[0]]};
				print $ofh "$line\n";
				shift @active_bot;
				$bot_count--;
				if($line =~ /bot ([0-9]{1,4}) gives (low|high) to (bot|output) ([0-9]{1,4}) and (low|high) to (output|bot) ([0-9]{1,4})/){

					if($6 eq "bot"){
						push @{ $bot[$7] }, pop $bot[$1];
						# print "bot $7 is now holding ", $bot[$7][0], " and ",$bot[$7][1], "\n";
						if(scalar @{ $bot[$7]}==2){
							# print "bot $7 is now holding ", $bot[$7][0], " and ",$bot[$7][1], "\n";
							push @active_bot, $7;
							$bot_count++;
						}
					}elsif ($6 eq "output"){
						push @{ $output_bin[$7] }, pop $bot[$1];
					}
					if($3 eq "bot"){
						push @{ $bot[$4] }, shift $bot[$1];
						# print "bot $4 is now holding ", $bot[$4][1], " and ",$bot[$4][1], "\n";
						if(scalar @{ $bot[$4]}==2){
							# print "bot $4 is now holding ", $bot[$4][0], " and ",$bot[$4][1], "\n";
							push @active_bot, $4;
							$bot_count++;
						}elsif(scalar @{ $bot[$4]}>2){
							print "MISTAKE HAPPENED";
						}

					}elsif ($3 eq "output"){
						push @{ $output_bin[$4] }, shift $bot[$1];
					}else{
						print "not recognized\n";
					}
					
				}
				
			}


		}

	}
}
foreach my $botnum (0..scalar @bot-1){

	if($bot[$botnum][1]){
		print $ofh "missed bot $botnum is holding:", $bot[$botnum][0], " ", $bot[$botnum][1], "\n";
	}
		
}
print "output 0: $output_bin[0][0]\n";
print "output 1: $output_bin[1][0]\n";
print "output 2: $output_bin[2][0]\n";
print "result: ", $output_bin[0][0]*$output_bin[1][0]*$output_bin[2][0], "\n";