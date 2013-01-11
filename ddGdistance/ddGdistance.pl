#!/usr/bin/perl -w
use strict;
use warnings;
use Statistics::Descriptive;

#TODO: first unify calculations by z_*.pl
#program takes differences of ddG (wt - mut???) and classifies all mutations according to distance between
#ddG(wt) = 0 (in most cases) and ddG(mt)

#File needed: processed output of FoldX with ddG values for wt and each of mutants. Format: AAid	ddG
if ($#ARGV != 0) {die "Program used with parameters [ddG list ]\n";}
open(OUT, "> ddG_ranked.txt") or die "Can not open an input file: $!";

my @cols=open_files($ARGV[0]);
my @wt=split(/\t/,$cols[0]);
#calculate differences between wt ddG and mt ddG
$ddG[0]=0;
$inx[0]=$wt[0];
for(my $i=1;$i<$#cols+1;$i++){
  my @mt=split(/\t/,$cols[$i]);
  $ddG[$i]=abs($mt[1]-$wt[1]);
  $inx[$i]=$mt[0];
}
#calculate percentiles
$stat = Statistics::Descriptive::Full->new();
$stat->add_data(@ddG);
my $p25 = $stat->percentile(25);
my $p50 = $stat->percentile(50);
my $p75 = $stat->percentile(75);
for(my $i=0;$i<$#ddG+1;$i++){
  if($ddG[$i] <= $p25){print OUT "$inx[0]\t0\n"}
  if($ddG[$i] <= $p50){print OUT "$inx[0]\t1\n"}
  if($ddG[$i] <= $p75){print OUT "$inx[0]\t2\n"}
  if($ddG[$i] > $p75){print OUT "$inx[0]\t3\n"}
}


sub open_file{
  my ($file_name)=@_;
  open(INP1, "< $file_name") or die "Can not open an input file: $!";
  my @file1=<INP1>;
  close (INP1);
  chomp @file1;
  return @file1;
}		