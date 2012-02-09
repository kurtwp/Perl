#!/usr/bin/perl

#This script will take an input file of region and dialcodes 
#and add 011 to the front of the dialcode and create a 
#comma separated file (region,locale,dialcode)
#using the dialcode as the locale.
#          Kurt w. Pasewaldt

use strict;
use warnings;
my $region = 0;  
my $locale = 0;
my @data = ();
my $new_region = 0;

open(FILE, "usa.csv") or die ("Cannot open");
@data = <FILE>;
close(FILE);
open(FILE, ">> MBMEACELLIUSAIN.txt") or die ("Cannot opea");
foreach my $line (@data) {
	chomp($line);
	($region, $locale) = split(/,/,$line);
	$region = "011".$region;
	$new_region = join(",",$region,$locale);
	print FILE "$new_region\n";
}
close(FILE);
print "Created file \"regions.txt\"\n";	

