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
  

  #print Dumper($results);
    $sth->execute() or die $DBI::errstr;
    my $i=0;

  while ( my @row = $sth->fetchrow_array ) {
    my ($cat_id, $cat_name, $cat_link ) = @row;
    @arrRtn[$i] = {
        'CatID'  => $cat_id,
        'CatName' => $cat_name,
        'CatLink' => $cat_link,
    };
    $i++;
}
      
$sth->finish();
my $error = 0;

#print Dumper(@arrRtn);
foreach (@arrRtn)
{
    $error = 0;
   # print "ID: $_->{'CatID'}\r\nNAME: $_->{'CatName'}\r\nLINK: $_->{CatLink}\r\n";

    if ($_->{'CatID'} < 1 || $_->{'CatID'} eq "") {
        $error = 1;
        
        #exit $error;
       # die ("Test Failed");
    
    }
    else {
        $error = 0;
    }
} 
if ($error == 0) {

#  system("/home/peter/deploy.sh");

}

print $error;
exit $error;
