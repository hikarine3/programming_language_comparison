my $str = "a,b,c";
my @array = split(',', $str);
foreach $elem (@array) {
    print($elem."\n");
}