use strict;
use FileHandle;
my $output_file = "/tmp/output_perl.txt";
if(my $fh = new FileHandle('> '.$output_file) ){
  print $fh "Hello World!\nAdditional line\n";
  $fh->close();
}
else{
  die("Failed to write to ".$output_file);
}

if(my $fh = new FileHandle($output_file) ){
  local $/ = undef;
  print <$fh>;
  $fh->close();
}