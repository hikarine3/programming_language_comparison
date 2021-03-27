my @array = (3, 1, 2);
my @sorted_array = reverse sort @array;
foreach my $item (@sorted_array) {
	print $item."\n";
}
