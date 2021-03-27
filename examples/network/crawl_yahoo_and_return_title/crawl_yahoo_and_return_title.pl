use HTML::TagParser;

my $target_url = "https://www.yahoo.com/";
my $html = HTML::TagParser->new($target_url);
my $title = $html->getElementsByTagName( "title" );
print $title->innerText()."\n" if ref $title;
