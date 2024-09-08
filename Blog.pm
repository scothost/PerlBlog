package Blog;
# Base class specific to the Blog application, defines methods we don't design in its children
use DBI;
use Data::Dumper;
use Moose;
extends 'DedicatedToServers';

our $dbh = DedicatedToServers->DbConnect();


sub new {
    my $class = shift;
    my $self = $class->SUPER::new; # attrs inherited from DedicatedToervers
    $self->{extended} = 1;
    return $self;
}

sub GetIndex() {
    my $sth = $dbh->prepare("
    SELECT *
    FROM Pages
    WHERE 
    PageName = 'index'"
    );
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
    $sth->finish();
    return($results);
 
}

sub WhoAmI() {

    my $sth = $dbh->prepare("
    SELECT *
    FROM Pages
    WHERE 
    PageName = 'whoami'"
    );
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
    $sth->finish();
    return($results);    
}



1;
