#!/usr/bin/perl 

use strict;
use warnings;
use Template;
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
my $Content = $d2s->GetIndex();
my $Top3    = $d2s->GetTop3Posts();
my $WhoAmI  = $d2s->WhoAmI();

my $vars = {
    categories => $Cats,
    content => $Content,
    top3    => $Top3,
    whoami => $WhoAmI,
    page => "index",
};

#print Dumper($vars);
$template->process('views/Layout.tt', $vars);
    
print "</body></html>";
