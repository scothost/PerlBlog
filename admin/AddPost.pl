#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use CGI;
use DedicatedToServers;
use Blog;
use User;
use Post;
use Category;
use Scalar::MoreUtils qw(empty);
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
my $d2s = DedicatedToServers->new(); 
my $Category = Category->new();
my $User = User->new();
my $Post = Post->new();
my $CatList = $Category->GetCategories();
my $Cats = $d2s->GetCAdminItems();
my $Users = $User->GetUsers();
my $req = new CGI; 

if (empty($SubmittedForm) )
{
   
}
elsif ( $SubmittedForm eq "Submit") {
 $Post->AddPost($CatID, $Title,$Summary,$Content);
}

my $vars = {
   admin => $Cats,
   users => $Users,
   catlist => $CatList,
};

$template->process('AddPost.tt', $vars);
    
print "</body></html>";
