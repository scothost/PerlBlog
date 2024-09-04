#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use CGI;
use DedicatedToServers;
use Blog;
use Data::Dumper;

print "Content-type:text/html\n\n";
print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='css/style.css' version=01>";

print "</head>\n\n";
print "<body>\n";

my $template = Template->new();
my $Blog = Blog->new(); 
my ($Cats,@arrRtn) = $Blog->GetCategories();
my $Users = $Blog->GetUsers();
my $req = new CGI; 
my $ActivePost = $req->param("pid");
my $Post = $Blog->GetPost($ActivePost);
my $Top3    = $Blog->GetTop3Posts();
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
