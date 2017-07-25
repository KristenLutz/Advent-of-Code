#!/usr/bin/perl
    use warnings;
    use strict;
    
    my $dirString = "R5, L2, L1, R1, R3, R3, L3, R3, R4, L2, R4, L4, R4, R3, L2, L1, L1, R2, R4, R4, L4, R3, L2, R1, L4, R1, R3, L5, L4, L5, R3, L3, L1, L1, R4, R2, R2, L1, L4, R191, R5, L2, R46, R3, L1, R74, L2, R2, R187, R3, R4, R1, L4, L4, L2, R4, L5, R4, R3, L2, L1, R3, R3, R3, R1, R1, L4, R4, R1, R5, R2, R1, R3, L4, L2, L2, R1, L3, R1, R3, L5, L3, R5, R3, R4, L1, R3, R2, R1, R2, L4, L1, L1, R3, L3, R4, L2, L4, L5, L5, L4, R2, R5, L4, R4, L2, R3, L4, L3, L5, R5, L4, L2, R3, R5, R5, L1, L4, R3, L1, R2, L5, L1, R4, L1, R5, R1, L4, L4, L4, R4, R3, L5, R1, L3, R4, R3, L2, L1, R1, R2, R2, R2, L1, L1, L2, L5, L3, L1";
    #my $dirString = "add direction string here";
    
    my @dirs=split(", ",$dirString);
    my @x_crds;
    my @y_crds;
    $x_crds[0]=0;
    $y_crds[0]=0;
    my $x=0;
    my $y=0;
    my $compass=1; # 1=N, 2=E, 3=S, 4=W
    my $moveCount=1;
    foreach my $move (@dirs){
    	my $turn = substr($move,0,1);
    	my $distance = substr($move,1,3);
    	if($turn eq 'R'){
    		$compass+=1;
    		if ($compass>4){
    			$compass = 1;
    		}
    	}else{
    		$compass-=1;
    		if($compass<1){
    			$compass=4
    		}
    	}
    	if($moveCount%2==1){
    		if($compass==2){
    			$x=$x+$distance;
    		}else{
    			$x=$x-$distance;
    		}
    	}else{
    		if($compass==1){
    			$y=$y+$distance;
    		}else{
    			$y=$y-$distance;
    			#print "Turn: $turn,South($compass), $distance\n";
    		}
    	}
    	$x_crds[$moveCount]=$x;
    	$y_crds[$moveCount]=$y;
    	$moveCount++;
    }
    print "x: $x, y: $y, total=",abs($x)+abs($y),"\n";
   	my %seen;

	foreach (0..scalar(@x_crds)){
   		print "$x_crds[$_], $y_crds[$_]\n";
   	}
   	# foreach (0..scalar(@x_crds)){
   	# 	my $string = "$x_crds[$_], $y_crds[$_]";
   	# 	next unless $seen{$string}++;
   	# 	print "$string are duplicated\n";
   	# 	print "distance =", abs($x_crds[$_])+abs($y_crds[$_]),"\n";
   	# }

