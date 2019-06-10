use strict;
use Data::Dumper;
use FileHandle;
use File::Basename;
use JSON;
use utf8;
binmode STDOUT, ':utf8';

my $file = dirname(__FILE__)."/input.json";
if(my $fh=new FileHandle($file)) {
    local $/ = undef;
    my $json_str = <$fh>;
    $fh->close();
    my $djson = decode_json( $json_str );
    foreach my $item (@{$djson->{"items"}}) {
        print $item->{"title"}."\n";
    }
}
else{
    die("Failed to open ".$file);
}