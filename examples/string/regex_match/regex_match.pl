my $value = "This is target";
if ( $value=~ m!tar?get!s ) {
    print "Found target\n";
}