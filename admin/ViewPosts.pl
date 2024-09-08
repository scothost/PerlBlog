#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use CGI;
use User;
use Post;
use Category;
use Data::Dumper;
use CGI::Carp; # send errors to the browser, not to the logfile
use CGI;


my $cgi = CGI->new(); # create new CGI object
print $cgi->header('text/html');

print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='../css/style.css' version=01>";
print "<meta charset='UTF-8'>";

print "</head>\n\n";
print "<body>\n";
my $CatID =  $cgi->param('cat');
my $Title = $cgi->param('title');
my $Summary = $cgi->param('editor2');
my $Content = $cgi->param('editor1');
my $SubmittedForm = $cgi->param('AddPost');
 

my $template = Template->new({
    INCLUDE_PATH => '/var/www/html/MyBlog/perl/admin/views',
    });
my $Blog = Blog->new(); 
my $User = User->new();
my $Post = Post->new();
my $Category = Category->new();
my $CatList = $Category->GetCategories();
my $PostList = $Post->GetAllPosts();
my $Cats = $Post->GetCAdminItems();
my $Users = $User->GetUsers();
my $req = new CGI;

my $vars = {
   admin => $Cats,
   users => $Users,
   catlist => $CatList,
   postlist => $PostList,
};

$template->process('ViewPosts.tt', $vars);

    
print "</body></html>";
