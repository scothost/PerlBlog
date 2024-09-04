package Category;
use DBI;
use Data::Dumper;
use Moose;
extends 'DedicatedToServers';

my $dbh = DedicatedToServers->DbConnect();

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

sub GetCategories {
    my $sth = $dbh->prepare("SELECT CatID, CatName, CatLink FROM Categories");
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
      

return($results);

$sth->finish();
}

1;


