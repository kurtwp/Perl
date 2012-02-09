#!/usr/bin/perl

use strict;

my $region = 0;  
my $locale = 0;
my @data = ();
my $new_region = 0;
my $digit =0;

open(FILE, "usa.csv") or die ("Cannot open");
@data = <FILE>;
close(FILE);
open(FILE, ">> regions2.txt") or die ("Cannot opea");
foreach my $line (@data) {
	chomp($line);
	($region, $locale) = split(/,/,$line,2);
	$digit = substr($locale,0,1);
	if ($digit == 1) {
		$locale = substr($locale,1);
		$new_region = join(",",$region,$locale);
		print FILE "$new_region\n";
} else {
	$locale = "011".$locale;
	$new_region = join(",",$region,$locale);
	print FILE "$new_region\n";
	}
}
close(FILE);
print "Created file \"regions.txt\"\n";	

