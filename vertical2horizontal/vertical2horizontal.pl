use FileHandle;
if(my $fh = new FileHandle($ARGV[0])) {
	local $/ = undef;
	my $con = <$fh>;
	$fh->close();
	$con=~ s!\n!\t!gs;
	print $con;
}
