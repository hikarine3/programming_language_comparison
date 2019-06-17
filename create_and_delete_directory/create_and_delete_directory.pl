use File::Path qw(make_path remove_tree);

my $root_dir = './example_directoy';
my $lang_dir = 'perl';
my $dirpath = join('/', $root_dir, $lang_dir);
unless(-d $dirpath){
  make_path($dirpath);
}
if(-d $dirpath) {
  print "Succeeded in creation of ".$dirpath."\n";
  if($root_dir=~ m![a-zA-Z\d_\-]!){
    remove_tree($root_dir);
  }
  if(-d $root_dir) {
    die("Failed to remove ".$root_dir)
  }
  else{
    print "Succeeded in removal of ".$dirpath."\n";
  }
}
else{
  print "Failed to mkdir -p ".$dirpath."\n";
}