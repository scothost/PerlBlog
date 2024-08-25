#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use CGI;
use Scalar::MoreUtils qw(empty);
use DedicatedToServers;
use Data::Dumper;
use CGI::Carp; # send errors to the browser, not to the logfile
use CGI;

my $cgi = CGI->new(); # create new CGI object

my $CatID =  $cgi->param('cat');



print $cgi->header('text/html');

print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='../css/style.css' version=01>";
print "<meta charset='UTF-8'>";
print "</head>\n\n";
print "<body>\n";

my $template = Template->new({
    INCLUDE_PATH => '/var/www/html/MyBlog/perl/admin/views',
    });
my $d2s = DedicatedToServers->new(); 
my $CatList = $d2s->GetCategories();
my $Cats = $d2s->GetCAdminItems();
my $Users = $d2s->GetUsers();
my $req = new CGI; 

if (!empty($CatID)) {
$d2s->DeleteCategory($CatID);
}


my $vars = {
   admin => $Cats,
   users => $Users,
   catlist => $CatList,
};

$template->process('DeleteCategory.tt', $vars);
    
print "</body></html>";
