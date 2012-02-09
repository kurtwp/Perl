#!/usr/bin/perl

#This script will take an input file of region and dialcodes 
#and add 011 to the front of the dialcode and create a 
#comma separated file (region,locale,dialcode)
#using the dialcode as the locale.
#          Kurt w. Pasewaldt

use strict;

my $region = 0;  
my $locale = 0;
my @data = ();
my $new_region = 0;

open(FILE, "usa.csv") or die ("Cannot open");
@data = <FILE>;
close(FILE);
open(FILE, ">> regions.txt") or die ("Cannot opea");
foreach my $line (@data) {
	chomp($line);
	($region, $locale) = split(/,/,$line,2);
	$locale = "011".$locale;
	$new_region = join(",",$region,$locale,$locale);
	print FILE "$new_region\n";
}
close(FILE);
print "Created file \"regions.txt\"\n";	

