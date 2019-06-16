use strict;
my $example_array = {1 => 'January', 12 => 'December', 3 => 'March' };
foreach my $key (reverse sort {$a <=> $b} keys %{$example_array}) {
   print $key. " => " . $example_array->{$key} ."\n";
}

