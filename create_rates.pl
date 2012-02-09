#!/usr/bin/perl -w
use strict;
use warnings;

my $count = 0;
my @dn = ();
my $dialcode = 0;
my $line = "";
my $random_number = 0;
my $range = 9999;
my $var_length = 0;

open(FILE, "6-digit-dn.csv") or die ("Cannot open 6-digits-dn.csv");
@dn = <FILE>;
close(FILE);
open(FILE, ">> under-vendor3.txt") or die ("Cannot create file");
foreach $line (@dn) {
  chomp($line);
  my $random_number = int(rand($range));
  $var_length = length($random_number);
  if ($var_length == 4){
    print FILE $line . ",0." . $random_number . "\n";
  } elsif ($var_length == 3) {
    print FILE $line . ",0.0" . $random_number . "\n";
  } elsif ($var_length == 2) {
    print FILE $line . ",0.00" . $random_number . "\n";
  } else {
    print FILE $line . ",0.000" . $random_number . "\n";
  }
}

