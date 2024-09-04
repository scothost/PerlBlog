#!/usr/bin/perl 
package DedicatedToServers;

use strict;
use warnings;
use DBI;
use Data::Dumper;




sub new 
{ 
    my $class = shift; # defining shift in $myclass 
    my $self = {}; # the hashed reference 
    return bless $self, $class; 
} 

our $dbh=DbConnect();

sub DbConnect {
my $dsn = 'DBI:mysql:' .
          ';mysql_read_default_group=local' .
          ';mysql_read_default_file=/etc/.mysqloptions';

my $dbh = DBI->connect($dsn, undef, undef, {
    PrintError => 0,
    RaiseError => 1
});
return $dbh;
}

sub GetUsers {
    my $sth = $dbh->prepare("SELECT * FROM Users");
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
      
$sth->finish();
return($results);

}

1;