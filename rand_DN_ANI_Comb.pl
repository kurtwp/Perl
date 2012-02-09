#!/usr/bin/perl -w
use strict;
use warnings;

my $count = 0;
my $range = 1000000;
my $prerange = 2;
my $preminrange = 3000;
my $prefix = "";
my $new_number = 0;
my $random_number = 0;
my $random_num = 0;
my @dn = ();
#my @ani = ();
my $case = "CASE-000-012-014;";

open (FILE, "dialno1MSeq") or die ("Cannot open dn.txt");
@dn = <FILE>;
close(FILE);
#open (FILE, "ani.txt") or die ("Cannot open ani.txt");
#@ani = <FILE>;
#close(FILE);
open(FILE, ">> CASE-000-012-014.txt") or die ("Cannot open file");
print FILE "RANDOM" . "\n";
for ($count = 0; $count <= 800000; $count++) {
  my $random_number = int(rand($range));
  chomp($dn[$random_number]);
  my $random_num = int(rand($range));
  chomp($dn[$random_num]);
  if ($dn[$random_number] && $dn[$random_num]) { 
    my $prefix = int(rand($prerange)) + $preminrange;
    $new_number = $case . $prefix . "#". $dn[$random_number] . ";" . $dn[$random_num] . ";";
    print FILE "$new_number \n";
  } 
}
close(FILE);



