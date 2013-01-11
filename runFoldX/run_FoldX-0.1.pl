#!/usr/bin/perl -w
use strict;
use warnings;

#Two files are needed: 1) pdb formated protein structure 2) list of variations
if ($#ARGV != 2) {die "Program used with parameters [pdb] [chainID] [list of variations]\n";}

my @tab = split (/\//,$ARGV[0]);
my $name = $tab[-1];
$name =~ s/.pdb//;
mkdir $name;
chdir $name or die "directory $name not present: $!";

#structure file list
`echo $ARGV[0] > list.txt `;

#chain ID
my $chID =$ARGV[1];

#parse_variations
my @variations=open_file($ARGV[2]);
my ($string);
foreach my $var(@variations){
	my $AA=substr($var,0,1);
	my $pos=substr($var,1);
	$pos =~ s/[A-Z]+//;
print "$AA $pos";	
	my $kod = $AA.$chID.$pos."a";
	$string = $string.",".$kod;
}

#prepare input file
open(FLDX, "> in-foldx_energy") or die "Can not open an input file: $!";
print FLDX '<TITLE>FOLDX_runscript;';
print FLDX '<JOBSTART>#;';
print FLDX '<PDBS>#;';
print FLDX '<BATCH>list.txt;';
print FLDX '<COMMANDS>FOLDX_commandfile;';
print FLDX "\<PositionScan\>foldx-scan.out\,$string\;";
print FLDX '<END>#;';
print FLDX '<OPTIONS>FOLDX_optionfile;';
print FLDX '<Temperature>298;';
print FLDX '<R>#;';
print FLDX '<pH>7;';
print FLDX '<IonStrength>0.050;';
print FLDX '<water>-CRYSTAL;';
print FLDX '<metal>-CRYSTAL;';
print FLDX '<VdWDesign>2;';
print FLDX '<OutPDB>false;';
print FLDX '<pdb_hydrogens>false;';
print FLDX '<complex_with_DNA> true;';
print FLDX '<END>#;';
print FLDX '<JOBEND>#;';
print FLDX '<ENDFILE>#;';

#foldxX run options
open(OPT, "> opt-scan") or die "Can not open an input file: $!";
print OPT "3";
print OPT "in-foldx_energy";

#run FoldX
# `FoldX.linux64 < opt-scan > energies-scan.out`;
 
 
 sub open_file{
        my ($file_name)=@_;
        open(INP1, "< $file_name") or die "Can not open an input file: $!";
        my @file1=<INP1>;
        close (INP1);
        chomp @file1;
        return @file1;
}		