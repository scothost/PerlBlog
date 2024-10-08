#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use Post;
use Category;
use Data::Dumper;

print "Content-type:text/html\n\n";
print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='css/style.css' version=01>";

print "</head>\n\n";
print "<body>\n";

my $template = Template->new(); 
my $Posts = Post->new();
my $Category = Category->new();
my $Cats = $Category->GetCategories();
my $Content = $Posts->GetIndex();
my $Top3    = $Posts->GetTop3Posts();
my $WhoAmI  = $Posts->WhoAmI();

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
