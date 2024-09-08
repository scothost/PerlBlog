#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use CGI;
#use DedicatedToServers;
use Blog;
use User;
use Post;
use Category;
use Data::Dumper;

print "Content-type:text/html\n\n";
print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='css/style.css' version=01>";

print "</head>\n\n";
print "<body>\n";

my $template = Template->new();
my $Blog = Blog->new();
my $User = User->new(); 
my $Posts = Post->new();
my $Category = Category->new();
my ($Cats,@arrRtn) = $Category->GetCategories();
my $Users = $User->GetUsers();
my $req = new CGI; 
my $ActivePost = $req->param("pid");
my $Post = $Posts->GetPost($ActivePost);
my $Top3    = $Posts->GetTop3Posts();
my $WhoAmI  = $Blog->WhoAmI();



my $vars = {
    categories => $Cats,
    users => $Users,
    post => $Post,
    top3 => $Top3,
    page => "Post",
    whoami => $WhoAmI,
};


$template->process('views/Layout.tt', $vars);
    
print "</body></html>";
