#!/usr/bin/perl -w
#List files in a directory
#
@files = <*>;
foreach $file (@files) {
print $file . "\n";
}

