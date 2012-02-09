#!/usr/bin/perl

#This script will add a prefix to numbers from a filed call
#16_dialcodes.  It will write it to a new and also
#copy data that is equal to a length of 10 and copy yhem
#to another file.

open(FILE, "16_dialcodes.txt") or 
die("Unable to open file");

@data = <FILE>;

 close(FILE);

open(FILE, ">> ani.txt") or die ("can open");
foreach $line (@data) {
	chomp($line);
	if (length($line) == 10) {
		print FILE ($line."\n");
	}
}
close(FILE);
open(FILE, "16_dialcodes.txt") or 
die("Unable to open file");
@data = <FILE>;
close(FILE);
open(FILE, ">> dnis.txt") or die ("can open");
foreach $line (@data) {
	chomp($line);
	print FILE ("331".$line."\n");
}
close(FILE);
