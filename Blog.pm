package Blog;
use DBI;
use Data::Dumper;
use Moose;
extends 'DedicatedToServers';

my $dbh = DedicatedToServers->DbConnect();


sub new {
    my $class = shift;
    my $self = $class->SUPER::new; # attrs inherited from Employee
    $self->{extended} = 1;
    return $self;
}

sub GetCategories {
    my $sth = $dbh->prepare("SELECT CatID, CatName, CatLink FROM Categories");
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
      

return($results);

$sth->finish();
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



sub AddNewCategory {
    my $content = $_[1];
    my $CatName = $_[2];
    my $CatLink = $_[3];

    my $sth = $dbh->prepare("
    INSERT INTO Categories (CatName, CatLink)
    VALUES ('$CatName','$CatLink')
"
    );
    $sth->execute() or die $DBI::errstr;
    print "<script>location.href='./ViewCategories.pl' </script>";
    $sth->finish();
}
sub DeleteCategory()
{
    my $cat = $_[1];
     my $sth = $dbh->prepare("
    DELETE FROM Categories WHERE CatID = '$cat'
    ");
    $sth->execute() or die $DBI::errstr;
    print "<script>location.href='./ViewCategories.pl' </script>";
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
