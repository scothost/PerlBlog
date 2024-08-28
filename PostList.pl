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
my $ActiveCategory = $req->param("id");
my $Posts = $d2s->GetPostsByCategory($ActiveCategory);
my $Top3    = $d2s->GetTop3Posts();
my $WhoAmI  = $d2s->WhoAmI();



my $vars = {
    categories => $Cats,
    users => $Users,
    posts => $Posts,
    active_categoty => $ActiveCategory,
    top3 => $Top3,
    page => "PostList",
    whoami => $WhoAmI,
};


$template->process('views/Layout.tt', $vars);
    
print "</body></html>";
