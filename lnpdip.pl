#!/usr/bin/perl  

use strict;
use English;
use Time::Local;

my $year = 0;
my $month = 0;
my $day = 0;
my $account_id = 0;
my $date = 0;
my $count = 0;
my $lnp_time = 0;
my $lnp_avg_time = 0;
my $lnp_high_time = 0;
my $lnp_total = 0;
my $good_total = 0;
my $bad_total = 0;
my $avg_dip = 0;
my $total = 0;
my @fields = ();
my @files = ();
my $i = 0;
my $temp = 0;
my $good_count = 0;
my $bad_count = 0;
my $lnp_count = 0;
my $lnp_dip_time = 0;
my $avg_dip_time = 0;

unlink ("redirect.txt");
unlink ("lnp.txt");

print "Enter year and month and optional day\n";
print " e.g. 2010 09 or 2010 09 01\n";
my $userinput = <STDIN>;
chomp($userinput);
($year, $month, $day) = split(' ', $userinput);
print "Enter account ID\n";
$account_id = <STDIN>;
chomp($account_id);
if ($day == " ") {
   $date = "srs.log".$year."-".$month."-";
} else {
   $date = "srs.log".$year."-".$month."-".$day."-";
}
if ($month > 12 or $month < 1) {
   print "Invalid month \n";
   exit;
}
print "$date\n";
@files = glob "/srv/srs/logs/$date*";
foreach my $files (@files) {
$day = substr($files,29,2);
    $avg_dip = 0;
    $lnp_avg_time = 0;
   my $count = 0;
	my $day_good_count = 0;
	my $day_bad_count = 0;
	my $day_lnp_count = 0;
	$i++;
    open(FILE, $files) or die ("Cannot open $files");
   while(<FILE>) {
	@fields = split;
       if ($account_id == $fields[8]) {
        	$count++;
		   if (($fields[13] > "299") && ($fields[13] < "303")) {
				$good_count++;
				$day_good_count++;
			}
			if (($fields[13] > "399") && ($fields[13] < "601")) {
				$bad_count++;
				$day_bad_count++;
			}
			if ($fields[15] eq "LRNDipTime:") {
	        	$lnp_count++;
	        	$day_lnp_count++;
				$lnp_dip_time += $fields[16]
         }
			if ($fields[16] eq "LRNDipTime:") {
				$lnp_count++;
				$day_lnp_count++;
				$lnp_dip_time += $fields[17]
			} 
				$avg_dip_time += $fields[-1];
      	}
}
	$temp = substr($files[$i],29,2);
	if ($day != $temp) {
	if ($lnp_count != 0) {
	my $name = substr($files,21,10);
		 my $lnp_avg_times = $lnp_dip_time / $lnp_count;
		 $lnp_avg_time = sprintf("%.3f",$lnp_avg_times);
		 open(FILE,">>lnp.txt") or die ("Cannot open tests.txt");
		 print FILE "$name"." $lnp_count" . " $lnp_avg_time \n";
                 $lnp_count = 0;
    	         $lnp_dip_time = 0;
	} 
	if (($good_count != 0) || ($bad_count != 0)) { 
		 my $name = substr($files,21,10);
	 	my $avg_dips = $avg_dip_time / ($good_count + $bad_count);
		 $avg_dip = sprintf("%.3f",$avg_dips);
		 open(FILE,">>redirect.txt") or die ("Cannot open tests.txt");
		 print FILE "$name"." $good_count" . " $bad_count". " $avg_dip\n";
		$good_count = 0;
      $bad_count = 0; 
    	$avg_dip_time = 0;
		close(FILE);
		}
	}
close(FILE);
$total += $count;
$good_total += $day_good_count;
$bad_total += $day_bad_count;
$lnp_total += $day_lnp_count;
}
close(FILE);
open(FILE,">>redirect.txt") or die ("Cannot open tests.txt");
print FILE "--------------------------------------------\n";
print FILE "Total account Dips = $total\n";
print FILE "Total 300 Dips = $good_total\n";
print FILE "Total 503 Dips = $bad_total\n";
close(FILE);
open(FILE,">>lnp.txt") or die ("Cannot open tests.txt");
print FILE "--------------------------------------------\n";
print FILE "Total LNP Dips = $lnp_total \n";
close(FILE);
print "Created files lnp.txt and redirect.txt\n";
