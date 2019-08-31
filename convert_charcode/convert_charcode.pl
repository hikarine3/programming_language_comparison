use Encode::EUCJPMS;
use URI::Escape;
my $utf8str = "車";
my $eucstr = $utf8str;
Encode::from_to($eucstr, "utf8", "eucjp-ms");
print uri_escape($eucstr)."\n";
$utf8str = $eucstr;
Encode::from_to($utf8str, "eucjp-ms", "utf8");
print($utf8str."\n");
