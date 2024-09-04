#!/usr/bin/perl 

use strict;
use warnings;
use Template;
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
my $Cats = $Blog->GetCategories();
my $Content = $Blog->GetIndex();
my $Top3    = $Blog->GetTop3Posts();
my $WhoAmI  = $Blog->WhoAmI();

my $vars = {
    categories => $Cats,
    content => $Content,
    top3    => $Top3,
    whoami => $WhoAmI,
    page => "index",
};

#print ${ $Cats->{categories} };

$template->process('views/Layout.tt', $vars);
    
print "</body></html>";
