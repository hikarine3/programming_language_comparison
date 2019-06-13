use File::Basename;
use FileHandle;
my $envfile = dirname(__FILE__)."/.env";
if(my $fh = new FileHandle($envfile)) {
    while(<$fh>) {
        chomp;
        my $line = $_;
        next if($line=~ m!^\#!);
        my ($key, $val) = split("=", $line);
        $val=~ s!^\"|\"\s*$!!gs;
        $ENV{$key} = $val;
    }
    $fh->close();
    print $ENV{"ENVVALUE"}."\n";
}