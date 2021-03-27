use File::Find;
my $dir = $ARGV[0] || '/.';
my $wanted = sub {
  if(-f $_) {
    print $File::Find::name."\n";
  }
};
&find($wanted, $dir, );
