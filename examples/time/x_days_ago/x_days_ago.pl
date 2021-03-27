my ($s, $mi, $h, $d, $m, $y) = localtime(time - 2 * 24 * 60 * 60);
print sprintf("%4d/%02d/%02d", $y + 1900, $m + 1, $d)."\n";
