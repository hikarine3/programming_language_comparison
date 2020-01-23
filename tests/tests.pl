use Carp::Assert;
use HTML::TagParser;
use LWP::UserAgent;
my $ua = new LWP::UserAgent;

my $target_url = "https://www.yahoo.com/";
my $resp = $ua->get($target_url);
if($resp->is_success) {
  my $html = HTML::TagParser->new($resp->content);
  my $title = $html->getElementsByTagName( "title" );
  if(ref $title){
    assert($title->innerText()=~ m!yahoo!i, "yahoo is not included in title");
    print("OK\n");
  }
  else{
    die("title tag is missing");
  }
}
else{
  die("Failed to crawl ".$target_url."\n".$resp->status_line);
}