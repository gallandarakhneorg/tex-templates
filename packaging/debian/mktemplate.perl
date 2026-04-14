#!/usr/bin/perl

use strict;

my $label = $ARGV[0] || die("no label given");
my $infile = $ARGV[1] || die("no input file given");
my $outfile = $ARGV[2] || die("no output file given");

local *INFILE;
local *OUTFILE;
open(*OUTFILE, ">$outfile") or die("$outfile: $!\n");
open(*INFILE, "<$infile") or die("$infile: $!\n");

while (my $line = <INFILE>) {
	$line =~ s/\Q||||PRODUCT_NAME||||\E/$label/g;
	print OUTFILE $line;
}

close(*INFILE);
close(*OUTFILE);
