package Post;
use DBI;
use Data::Dumper;
use Moose;
extends 'Blog';

my $dbh = Blog->DbConnect();


sub new {
    my $class = shift;
    my $self = $class->SUPER::new; # attrs inherited from Blog
    $self->{extended} = 1;
    return $self;
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
    print "<script>location.href='./ViewPosts.pl' </script>";
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
    print "<script>location.href='./ViewPosts.pl' </script>";
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


1;