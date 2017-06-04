use strict;
my $example_array = {1 => 'Janualry', 12 => 'December', 3 => 'March' };
foreach my $key (sort {$a <=> $b} keys %{$example_array}) {
   print $key. " => " . $example_array->{$key} ."\n";
}

