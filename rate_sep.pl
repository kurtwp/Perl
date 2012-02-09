#!/usr/bin/perl

use strict;

my $dial = 0;  
my $rate = 0;
my @data = ();
my $new_region = 0;
my $digit =0;

open(FILE, "usa.csv") or die ("Cannot open");
@data = <FILE>;
close(FILE);
open(FILE, ">> MBM-MBCI-Rate-mbno-in.txt") or die ("Cannot opea");
foreach my $line (@data) {
	chomp($line);
	($dial,$rate) = split(/,/,$line,2);
	$digit = substr($dial,0,1);
	print "$digit\n";
	if ($digit == 1) {
		$dial = substr($dial,1);
		$new_region = join(",",$dial,$rate);
		print FILE "$new_region\n";
} else {
	$dial = "011".$dial;
	$new_region = join(",",$dial,$rate);
	print FILE "$new_region\n";
	}
}
close(FILE);
print "Created file \"regions.txt\"\n";	

