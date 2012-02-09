#!/usr/bin/perl

#This script will add a prefix to numbers from a file
#It will write it to a new file and also
#copy data that is equal to a length of 10 and copy them
#to another file.

open(FILE, "MBM-IUUN21.csv") or 
die("Unable to open file");
@data = <FILE>;
close(FILE);
open(FILE, ">> dnis.txt") or die ("can open");
foreach $line (@data) {
	chomp($line);
	print FILE ("0".$line."\n");
}
close(FILE);