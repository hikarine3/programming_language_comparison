use strict;
my $example_array = {'January' => 1, 'December' => 12, 'March' => 3 };
foreach my $key (sort {$example_array->{$a} <=> $example_array->{$b}} keys %{$example_array}) {
   print $key. " => " . $example_array->{$key} ."\n";
}

