use File::Find;
use FileHandle;

my $dir = $ARGV[0] || die "Please input subdirectory name";

my $find = sub {
	my $file = $_;
	if(-f $file) {
		my $fh = new FileHandle($file);
		local $/ = undef;
		my $con = <$fh>;
		$fh->close();

		print "Opened: ".$File::Find::name."\n";
		print "Content: ".$con;

	}
};
print "Find in ".$dir."\n";
find($find, $dir);

