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
1;