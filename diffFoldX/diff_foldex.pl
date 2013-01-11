use strict;
use warnings;

if ($#ARGV != 0) {die "Program requires parameters! [data]\n";}

my $n1=substr($ARGV[0],0,rindex($ARGV[0],"."));
open(OUT, "> $n1.diff.txt") or die "Can not open an output file: $!";
open(DANE, "< $ARGV[0]") or die "Can not open an input file: $!";
my @data=<DANE>;
close (DANE);
chomp @data;

my @wt=split(/\t/,$data[0]);
#print "$wt[0]\n";
for my $i (1..$#data){
    my @linia=split(/\t/,$data[$i]);
    print OUT "$linia[0]\t";    
	for my $k (1..$#linia){
		my $dif=$linia[$k]-$wt[$k];	
		printf OUT "%6.2f\t", $dif;
	}
	print OUT "\n";
}

