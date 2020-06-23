use strict;
use File::Basename;
my $exit_dir = dirname(__FILE__).'/a_dir';
my $not_exist_dir = dirname(__FILE__).'/b_dir';
if(-d $exit_dir) {
  print "Found: ".$exit_dir."\n";
}
unless(-d $not_exist_dir) {
  print "Not Found: ".$not_exist_dir."\n";
}