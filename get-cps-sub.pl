#!/usr/bin/perl -w

# Kurt W. Pasewaldt
# The program will generate CPS from Nextone CDRs
# Store them in a file called cps.txt and cps-a.txt

use strict;
use Cwd;

my $path = "/var/cdrs";
my $home = getcwd;

print "Delete cps.txt and cps-a.txt\n";
print "type yes to delete or type no to keep\n";
my $userinput = <STDIN>;
chomp($userinput);
if ($userinput eq "yes") {
	unlink("/root/cps.txt");
	unlink("/root/cps-a.txt");
}
print "Enter date (Tyyyymmdd) or type exit to leave program: \n";
$userinput = <STDIN>;
chomp($userinput);

chdir($path) or die "Cant chdir to $path $!";

while ($userinput ne "exit") {
my $current_cps = 0;
my $cdr = 0;
my $cdr_files = 0;
my @list = 0;
my $space = " ";
my @files = glob "$userinput*.CDR";
foreach my $file (@files) {
	my $cps = 0;
	my $start = 0;
	my $total_seconds = 900;
	my $stime = 0;
	my $temp = 0;
	my $line = 0;
	my $save = 0;
	$cdr_files++;
	if (! -z $file) {
		open(FILE, $file) or die ("Cannot open $file");
		while (<FILE>) {
			$line++;
		}
		close(FILE);
		$temp = $line / $total_seconds;
		$cps = sprintf("%.2f",$temp);
		if ($cps > $current_cps) {
			$cdr = $file;
			$current_cps = $cps;
		}
		$save = $file.$space.$cps.$space.$line;
		push (@list, $save);
	}
}
print $current_cps.":".$cdr_files.":".$cdr."\n";
close(FILE);
my %count;
my @values = glob "$cdr";
my $time = 0;
my $i = 0;
foreach my $values (@values) {
	open(FILE, $values) or die ("Cannot");
	while(<FILE>) {
	chomp();
	($time) = (split(";")) [0];
	$count{$time}++;
	}
}
close(FILE);
# Will sort a hash by the hash values in descending order
my @value = sort {$count{$b} <=> $count{$a}} keys %count;
#############################################
# Will sort a hash by the hash values in ascending order
#@value = sort {$count{$a} <=> $count{$b}} keys %count;
######################################################
open(FILE, ">>/root/cps-a.txt") or die ("cannot open cps-a.txt");
print FILE $cdr . "\n";
foreach my $value (@value) { 
	$i++;
	open(FILE, ">>/root/cps-a.txt") or die ("cannot open cps-a.txt");
	print FILE "$value: $count{$value}"."\n";
	if ( $i == 10) {last}
}
my $name = substr($cdr, 0, 11);
my @f = grep /$name/, @list;
foreach (@f) {
	open(FILE,">>/root/cps.txt") or die ("cannot open cps.txt");
	print FILE $_ ."\n";
}
print FILE "\n";

print "Enter date (Tyyyymmdd) or type exit to leave program: \n";
$userinput = <STDIN>;
chomp($userinput);
}
close(FILE);
#end program
