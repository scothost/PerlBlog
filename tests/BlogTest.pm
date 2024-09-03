package BlogTest;


use Template;
use DBI;
use base qw(Test::Unit::TestCase);
use DedicatedToServers;
use Data::Dumper;
use diagnostics; # this gives you more debugging information
use warnings;    # this warns you of bad practices
use strict;      # this prevents silly errors
use Test::More qw( no_plan ); # for the is() and isnt() functions
use String::Util qw(trim);


my $d2s = DedicatedToServers->new();
my ($Cats,@arrRtn) = $d2s->GetCategories();
my $dsn = 'DBI:mysql:' .
          ';mysql_read_default_group=local' .
          ';mysql_read_default_file=/etc/.mysqloptions';
          my $dbh = DBI->connect($dsn, undef, undef, {
    PrintError => 0,
    RaiseError => 1
});

  my $sth = $dbh->prepare("SELECT CatID, CatName, CatLink FROM Categories");
    $sth->execute() or die $DBI::errstr;
    
    my $results = $sth->fetchall_arrayref({});
  

    my @resArr = @{$results};   
    $sth->finish();
    my $error = 0;
    my $rows = $sth->rows;
   
  if  (!$rows) {
        $error = 1;
       
        #exit ($error);
    
    }

  # print "ERR $error\r\n";

print  $error;
