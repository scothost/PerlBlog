#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use Scalar::MoreUtils qw(empty);
use CGI;
use User;
use Post;
use Category;
use Data::Dumper;
use CGI::Carp; # send errors to the browser, not to the logfile
use CGI;

my $cgi = CGI->new(); # create new CGI object
my $PostID =  $cgi->param('post');



print $cgi->header('text/html');

print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='../css/style.css' version=01>";
print "<meta charset='UTF-8'>";
print "</head>\n\n";
print "<body>\n";

my $template = Template->new({
    INCLUDE_PATH => '/var/www/html/MyBlog/perl/admin/views',
    });

my $User = User->new();
my $Post = Post->new();
my $PostList = $Post->GetAllPosts();
my $Cats = $Post->GetCAdminItems();
my $Users = $User->GetUsers();
my $req = new CGI; 

if (not empty($PostID)){
$Post->DeletePost($PostID);
}

my $vars = {
   admin => $Cats,
   users => $Users,
   postlist => $PostList,
};

$template->process('DeletePost.tt', $vars);
    
print "</body></html>";
