#!/usr/bin/perl

use strict;
use Time::localtime;



my @acct = ();
my $acct = 0;
my %count;
my $date = 0;
my $day = 0;
my $month = 0;
my $temp = 0;
my $time = 0;
my $year = 0;

$time = localtime;
$day = $time->mon;
if ($day < 10) {
	$day = "0" .$day;
}
$date = join('-',$time->year + 1900,$day); 
print "$date\n";


unlink ("total_count.txt");
@acct = glob "srs.log$date*";
foreach $acct (@acct) {
	open(FILE, $acct) or die ("Cannot open");
	while(<FILE>) {
		chomp();
		($temp) = (split(" ")) [8];
		if (($temp > 0) && ($temp < 200)) {
			$count{$temp}++;
		}	
	}
}
close(FILE);
open(FILE,">>total_count.txt") or die ("cannot create");
while (my ($k, $v) = each %count) {
	print FILE "Account: $k, Dips: $v.\n"
}
print "All data can be found in text file named \"total_count.txt\"\n";
close(FILE);

	