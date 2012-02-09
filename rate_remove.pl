#!/usr/bin/perl

#This script will take an input file of region and dialcodes 
#and add 011 to the front of the dialcode and create a 
#comma separated file (region,locale,dialcode)
#using the dialcode as the locale.
#          Kurt w. Pasewaldt

use strict;

my $dialcode = 0;  
my $rate = 0;
my @data = ();
my $new_rate = 0;

open(FILE, "usa.csv") or die ("Cannot open");
@data = <FILE>;
close(FILE);
open(FILE, ">> MBM-usa-sale-rates.txt") or die ("Cannot opea");
foreach my $line (@data) {
	chomp($line);
	($dialcode, $rate) = split(/,/,$line,2);
	$rate = 0.05;
	$new_rate = join(",",$dialcode,$rate);
	print FILE "$new_rate\n";
}
close(FILE);
print "Created file \"MBM-usa-rates.txt\"\n";	

