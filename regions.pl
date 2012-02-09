#!/usr/bin/perl

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
	$locale = substr($locale,1);
	if (length($locale) == 7) {
		$new_region = join(",",$region,$locale);
		print FILE "$new_region\n";
	}
}
close(FILE);
print "Created file \"regions.txt\"\n";	

