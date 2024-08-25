#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use Scalar::MoreUtils qw(empty);
use CGI;
use DedicatedToServers;
use Data::Dumper;
use CGI::Carp; # send errors to the browser, not to the logfile
use CGI;

my $cgi = CGI->new(); # create new CGI object

my $content =  $cgi->param('editor1');
my $CatName =  $cgi->param('CatName');
my $CatLink =  $cgi->param('CatLink');


print $cgi->header('text/html');
print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='../css/style.css' version=01>";

print "</head>\n\n";
print "<body>\n";

my $template = Template->new({
    INCLUDE_PATH => '/var/www/html/MyBlog/perl/admin/views',
    });
my $d2s = DedicatedToServers->new(); 
my $Cats = $d2s->GetCAdminItems();
my $Users = $d2s->GetUsers();
my $req = new CGI; 


my $vars = {
   admin => $Cats,
users => $Users,
};

if (!empty($CatName)) {
 $d2s->AddNewCategory($content,$CatName,$CatLink);
}


$template->process('AddCategory.tt', $vars);    
print "</body></html>";
