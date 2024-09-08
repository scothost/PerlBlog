#!/usr/bin/perl 

use strict;
use warnings;
use Template;
use User;
use Post;
use Category;
use Data::Dumper;

print "Content-type:text/html\n\n";
print "<html><head><title>DedicatedToServers</title>";
print "<link rel='stylesheet' type='text/css' href='../css/style.css' version=01>";


print "</head>\n\n";
print "<body>\n";

my $template = Template->new({
    INCLUDE_PATH => '/var/www/html/MyBlog/perl/admin/views',
    });
my $Posts = Post->new(); 
my $Cats = $Posts->GetCAdminItems();


my $vars = {
    admin => $Cats,
};

#print Dumper($vars);
$template->process('index.tt', $vars);
    
print "</body></html>";
