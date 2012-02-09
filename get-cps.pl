#!/usr/bin/perl -w

# Kurt W. Pasewaldt
# The program will generate CPS from Nextone CDRs
# Store them in a file called cps.txt

use Cwd;

my $path = "/var/cdrs";
my $home = getcwd;
my $current_cps = 0;
my $cdr = 0;
my $cdr_files = 0;

unlink("cps.txt"); # Deletes the file cpc.txt
chdir($path) or die "Cant chdir to $path $!";
my @files = glob "T*.CDR";
foreach $file (@files) {
	my $cps = 0;
	my $start = 0;
	my $total_seconds = 0;
	my $stime = 0;
	my $temp = 0;
	my $line = 0;
	$cdr_files++;
	if (! -z $file) {
		open(FILE, $file) or die ("Cannot open $file");
		while (<FILE>) {
			$line++;
			chomp();
			($stime) = (split(";")) [1];
			if ($start == 0) {$start = $stime}
		}
		close(FILE);
		$total_seconds = $stime - $start + 1;
		$temp = $line / $total_seconds;
		$cps = sprintf("%.2f",$temp);
		if ($cps > $current_cps) {
			$cdr = $file;
			$current_cps = $cps;
		}
		open(FILE, ">>cps.txt") or die ("can not open cps.txt");
		print FILE $file .":".$cps." Calls =".$line." Total =".$total_seconds." Start =".$start.": sTime ".$stime."\n";
	}
}
print FILE $current_cps.":".$cdr.":".$cdr_files."\n";
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
print $cdr_files."\n";
foreach $value (sort{$count{$a} cmp $count{$b} } keys %count) {
	$i++;
	print "$value: $count{$value}"."\n";
	if ( $i == $cdr_files) {last}
}

#end program
