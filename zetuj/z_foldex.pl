
use strict;
use warnings;

if ($#ARGV != 0) {die "Program requires parameters! [data]\n";}

open(OUT, "> $ARGV[0].zout") or die "Can not open an output file: $!";
open(DANE, "< $ARGV[0]") or die "Can not open an input file: $!";
my @data=<DANE>;
close (DANE);
chomp @data;

my $actives=0;
my (@sumy,@sx,@averages,@stdev);
my @tab=split(/\t/,$data[0]);
my $nv=@tab-1;
my $nr=$#data+1;

for my $k (1..$nv){
	$sumy[$k]=0;
	$sx[$k]=0;
}

for my $i (0..$#data){
        my @linia=split(/\t/,$data[$i]);
	for my $k (1..$#linia){
		$sumy[$k]=$sumy[$k]+$linia[$k];
	}
}

for my $k (1..$nv){
	$averages[$k]=$sumy[$k]/$nr;
}

for my $i (0..$#data){
	my @linia=split(/\t/,$data[$i]);
	for my $k (1..$#linia){
		my $x=($linia[$k]-$averages[$k])**2;
		$sx[$k]=$sx[$k]+$x;
	}
}

for my $k (1..$nv){
        $stdev[$k]=sqrt($sx[$k]);
	#print "$averages[$k] $stdev[$k]\n";
}


for my $i (0..$#data){
	my @linia=split(/\t/,$data[$i]);
	my (@z);
	my $zsum=0;
        for my $k (1..$#linia){
		if($stdev[$k] gt 0){
			$z[$k]=($linia[$k]-$averages[$k])/$stdev[$k];
		}
	}
	$zsum=$z[2]+$z[3]+$z[4]+$z[5]+$z[6]+$z[7]+$z[8]+$z[9]+$z[10];
	printf OUT "%s\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\n",$linia[0],$z[1],$z[2],$z[3],$z[4],$z[5],$z[6],$z[7],$z[8],$z[9],$z[10];
	printf "%s\t%6.2f\t%6.2f\n",$linia[0],$z[1],$zsum;
}

