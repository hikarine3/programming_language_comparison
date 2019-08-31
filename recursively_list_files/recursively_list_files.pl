use File::Find;
my $dir = $ARGV[0] ||  '.';
my $wanted = sub {
  print $_."\n";
}
&find($dir, $wanted);
