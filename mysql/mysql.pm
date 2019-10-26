package MySQL;
use DBI;
use Dotenv;

sub new() {
  my $self = {};
  Dotenv->load();
  return bless $self;
}

sub dbconnect(){
  my $self = shift;
  my $database = "mysql";
  $self->{'mdbh'} = DBI->connect("DBI:mysql:".$database.":".$ENV{'DBHOST'}, $ENV{'DBUSER'}, $ENV{'DBPASSWORD'}) or die "Failed to connect to mysqldb.";
}

sub dbclose(){
  my $self = shift;
  $self->{'mdbh'}->disconnect();
}

sub showSystemUsers(){
  my $self = shift;
  my $sql = 'SELECT host,user,Select_priv FROM mysql.user';
  my $sth = $self->{'mdbh'}->prepare($sql);
  $sth->execute();
  while(my $row_ref = $sth->fetchrow_hashref) {
    print(join("\t", $row_ref->{'host'}, $row_ref->{'user'}, $row_ref->{'Select_priv'})."\n");
  }
  $sth->finish();
}

if ($0 eq __FILE__) {
  my $rdb = new MySQL();
  $rdb->dbconnect();
  $rdb->showSystemUsers();
  $rdb->dbclose();
}
else{
  1;
}