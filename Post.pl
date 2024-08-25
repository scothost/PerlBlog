#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use CGI;
use DedicatedToServers;
use Data::Dumper;

print "Content-type:text/html\n\n";
print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='css/style.css' version=01>";

print "</head>\n\n";
print "<body>\n";

my $template = Template->new();
my $d2s = DedicatedToServers->new(); 
my $Cats = $d2s->GetCategories();
my $Users = $d2s->GetUsers();
my $req = new CGI; 
my $ActivePost = $req->param("pid");
my $Post = $d2s->GetPost($ActivePost);
my $Top3    = $d2s->GetTop3Posts();
my $WhoAmI  = $d2s->WhoAmI();



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
