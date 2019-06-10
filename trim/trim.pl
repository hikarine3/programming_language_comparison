my $a = "   aaa    \n\t";
$a=~ s!^\s*|\s*$!!gs;
print($a."\n");
