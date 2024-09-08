package Blog;
use DBI;
use Data::Dumper;
use Moose;
extends 'DedicatetToServers';

my $dbh = DedicatedToServers->DbConnect();


sub new {
    my $class = shift;

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
    return($results);
    $sth->finish();
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
