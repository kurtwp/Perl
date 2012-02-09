#!/usr/bin/perl 

#----------------------------------------------------
#Program demostrates how to use perl to log into
#an remote MySQL DB.
#---------------------------------------------------

use warnings;
use DBI;

my $db = "wordpress";
my $user = "zoo";
my $pass = "zxzxzx";
my $host = "terra.example.com";
my $port = "3306";

DBI->trace(0);

my $dbh = DBI->connect("DBI:mysql:database=$db;host=$host;port=$port", 
                       $user, $pass, { RaiseError => 1 } ) or
   die ( "Couldn't connect to database: " . DBI->errstr );
my $getkey = $dbh -> prepare("SHOW TABLES") or die ("TABLES failed $DBI::errstr\n");
$getkey -> execute or die ("execute failed: DBI::errstr\n");

print ("Tables in test database on $host, port $port\n");
while (@row = $getkey->fetchrow) {
        print "@row\n";
        }
$dbh->disconnect();
