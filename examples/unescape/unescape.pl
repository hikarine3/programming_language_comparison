use URI::Escape;
my $orig = "toyota%20%E8%BB%8A";
print uri_unescape($orig)."\n";
