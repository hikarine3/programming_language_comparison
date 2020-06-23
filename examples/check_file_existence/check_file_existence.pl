use strict;
use File::Basename;
my $exit_file = dirname(__FILE__).'/a.txt';
my $not_exist_file = dirname(__FILE__).'/b.txt';
if(-f $exit_file) {
  print "Found: ".$exit_file."\n";
}
unless(-f $not_exist_file) {
  print "Not Found: ".$not_exist_file."\n";
}