my $check_value = $value = "This is target 1.
Name is apple.
Target 2 is here. 
Name is orange.";
$check_value=~ s{target\s([\d+]).*?Name\s+is\s+([^\.]+)\.}{
    print $1.'='.$2."\n";
}gesix;
