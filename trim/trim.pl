my $a = "   aaa    ";
$a=~ s!^\s*|\s*$!!gs;
print($a."\n");
