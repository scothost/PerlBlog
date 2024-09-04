#!/usr/bin/perl 
package DedicatedToServers;

use strict;
use warnings;
use DBI;
use Data::Dumper;


my $dsn = 'DBI:mysql:' .
          ';mysql_read_default_group=local' .
          ';mysql_read_default_file=/etc/.mysqloptions';

my $dbh = DBI->connect($dsn, undef, undef, {
    PrintError => 0,
    RaiseError => 1
});

sub new 
{ 
    my $class = shift; # defining shift in $myclass 
    my $self = {}; # the hashed reference 
    return bless $self, $class; 
} 

sub GetCategories {
    my $sth = $dbh->prepare("SELECT CatID, CatName, CatLink FROM Categories");
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
      

return($results);

$sth->finish();
}

sub GetUsers {
    my $sth = $dbh->prepare("SELECT * FROM Users");
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
      
$sth->finish();
return($results);
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

sub GetPostsByCategory {
    my $Category = $_[1];
    my $sth = $dbh->prepare("
    SELECT *, Users.UserName,Users.UserEmail
    FROM Users, Posts 
    WHERE 
    Posts.PostOwner = Users.UserID
    AND
    Posts.PostCategory=$Category"
    );
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
    $sth->finish();
    return($results);
}
sub GetPost() {
    my $PostID = $_[1];
    my $sql = "
    SELECT *, Users.UserName,Users.UserEmail
    FROM Users, Posts 
    WHERE 
    Posts.PostOwner = Users.UserID
    AND
    PostID = $PostID
    ";

    my $sth = $dbh->prepare($sql);
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
    $sth->finish();
    return($results);
}
sub GetAllPosts {
    my $sth = $dbh->prepare("
    SELECT *, Users.UserName,Users.UserEmail
    FROM Users, Posts 
    WHERE 
    Posts.PostOwner = Users.UserID"
    );
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
    $sth->finish();
    return($results);    
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

sub GetCAdminItems()
{
     my $sth = $dbh->prepare("
    SELECT * FROM Config"
    );
    $sth->execute() or die $DBI::errstr;
    my $results = $sth->fetchall_arrayref({});
    $sth->finish();
    return($results);        
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
sub DeletePost()
{
    my $cat = $_[1];
    my $sth = $dbh->prepare("
    DELETE FROM Posts WHERE PostID = '$cat'
    ");
    $sth->execute() or die $DBI::errstr;
    print "<script>location.href='./ViewPosts.pl' </script>";
    $sth->finish();
}

sub AddPost() {
    my $CatID = $_[1];
    my $Title = $_[2];
    my $Summary = $_[3];
    my $Content = $_[4];
    my $sth = $dbh->prepare("
    INSERT INTO Posts (PostOwner, PostCategory, PostPublished, PostTitle, PostSummary, PostContent)
    VALUES 
    (
     1,$CatID,1,'$Title','$Summary','$Content'
    )
    ");
    $sth->execute() or die $DBI::errstr;
    print "Record added <a href='./AddPost.pl'>Click to refresh</a>";
    $sth->finish();    
}
sub UpdatePost() {

    my $sql = "
    UPDATE Posts 
    SET PostTitle = '$_[1]->{title}',
    PostSummary = '$_[1]->{summary}',
    PostContent = '$_[1]->{content}'
    WHERE PostID = $_[1]->{'id'}";

    my $sth = $dbh->prepare($sql);
    $sth->execute() or die $DBI::errstr;
    print "Record updated <a href='./EditPost.pl'>Click to refresh</a>";
    $sth->finish();
}

sub GetTop3Posts() {

    my $sth = $dbh->prepare("
    SELECT * FROM Posts, Users
    WHERE
    Posts.PostOwner = Users.UserID
    ORDER BY RAND() 
    LIMIT 6"
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
