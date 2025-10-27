#!/usr/bin/perl -w
use strict;
use warnings;

my $count = 0;
my @dn = ();
my $dialcode = 0;
my $line = "";
my $random_number = 0;
my $range = 10000;
my $var_length = 0;

open(FILE, "6-digit-dn.csv") or die ("Cannot open 6-digits-dn.csv");
@dn = <FILE>;
close(FILE);
open(FILE, ">> under-vendor3.txt") or die ("Cannot create file");
foreach $line (@dn) {
  chomp($line);
  my $random_number = int(rand(10000));
  $var_length = length($random_number);
  my $formatted_number = sprintf("%04d", $random_number);
  print FILE "$line" . ",0." . "$formatted_number\n";
