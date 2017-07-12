use strict;
use FileHandle;
my $output_file = "/tmp/output_perl.txt";
if (my $fh = new FileHandle('> '.$output_file)) {
  print $fh "Hello World!\n";
  $fh->close();
}

if (my $fh = new FileHandle($output_file)) {
  local $/ = undef;
  print <$fh>;
  $fh->close();
}

