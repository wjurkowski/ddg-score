#!/usr/bin/perl -ws
use strict;
use warnings;

#program takes SNV key (symbol-variation) and prepares lists of mutated residues.
#SNV key is as in all input files used for SNV effects predictions
#Output file of this script is an input file for run_FoldX.pl
#Input file: list of variations
if ($#ARGV != 0) {die "Program used with parameters [list of variations]\n";}

#parse_variations
my @variations=open_file($ARGV[2]);
foreach my $var(@variations){
	my @tab=split(/\t/,$var);
	my $symbol=$tab[2];
	my $wt=$tab[6];
	my $pos=$tab[7];
	my $mt=$tab[8];
	my $key=$tab[6].$tab[7].$tab[8];
	my $name=$symbol."-mut";
	open(OUT, ">>$name") or die "Can not open an input file: $!";	
	print OUT "$key\n";
}

sub open_file{
  my ($file_name)=@_;
  open(INP1, "< $file_name") or die "Can not open an input file: $!";
  my @file1=<INP1>;
  close (INP1);
  chomp @file1;
  return @file1;
}		
