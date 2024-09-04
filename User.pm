package User;
use DBI;
use Data::Dumper;
use Moose;
extends 'DedicatedToServers';

my $dbh = DedicatedToServers->DbConnect();


sub new {
    my $class = shift;
    my $self = $class->SUPER::new; # attrs inherited from Blog
    $self->{extended} = 1;
    return $self;
}

sub GetUsers {
    my $sth = $dbh->prepare("SELECT * FROM Users");
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
      
$sth->finish();
return($results);

}

1;