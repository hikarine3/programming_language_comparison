package MysqlManipulator;
use strict;
use DBI;
use Dotenv;

sub new() {
  my $self = {};
  Dotenv->load();
  return bless $self;
}

sub beginTransaction(){
  my $self = shift;
  my $sql = "BEGIN";
  $self->executeSQL($sql);
}

sub createExampleData(){
  my $self = shift;
  my @datas = (
    ['name1', 'male'],
    ['name2', 'female']
  );
  my $sth = $self->{'rdbh'}->prepare("INSERT INTO example (name, sex) VALUES (?, ?)");
  foreach my $data_ref (@datas) {
    $sth->execute($data_ref->[0], $data_ref->[1]);
  }
  $sth->finish();
}

sub createExampleTable() {
  my $self = shift;
  my $sql = <<EOF;
CREATE TABLE example (
  id int NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  sex ENUM('male', 'female') DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT NOW(),
  updated_at timestamp NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  KEY `created_at_idx` (`created_at`),
  KEY `name_idx` (`name`),
  KEY `updated_at_idx` (`updated_at`)
);
EOF
  $self->executeSQL($sql);
}

sub dbclose(){
  my $self = shift;
  $self->{'rdbh'}->disconnect();
}

sub dbconnect(){
  my $self = shift;
  my $database = "example";
  my $timezone = "Asia/Tokyo";
  my $dbi = 'mysql';
  $self->{'rdbh'} = DBI->connect("DBI:".$dbi.":database=".$database.";host=".$ENV{'DBHOST'}, $ENV{'DBUSER'}, $ENV{'DBPASSWORD'}, {
   AutoCommit => 0,
   PrintError => 1,
   PrintWarn => 0
   }) or die "Failed to connect to db.";
  my $sql = "SET TIME_ZONE='".$timezone."'";
  $self->{'rdbh'}->do($sql);
}

sub dropExampleTable(){
  my $self = shift;
  my $sql = "DROP TABLE IF EXISTS example";
  $self->executeSQL($sql);
}

sub endTransaction(){
  my $self = shift;
  $self->{'rdbh'}->commit();
}

sub executeSQL(){
  my $self = shift;
  my $sql = shift;
  $self->{'rdbh'}->do($sql) or die("Failed to execute ".$sql);
}

sub selectFromExampleTable(){
  my $self = shift;
  my $sql = "SELECT id, name, sex, DATE_FORMAT(created_at, '%Y/%m/%d %H:%i:%S') AS created_at, DATE_FORMAT(updated_at, '%Y/%m/%d %H:%i:%S') AS updated_at FROM example";
  my $sth = $self->{'rdbh'}->prepare($sql) or die("Failed to prepare ".$sql);
  $sth->execute() or die("Failed to execute ".$sql);
  while(my $row_ref = $sth->fetchrow_hashref) {
    print(join("\t", $row_ref->{'id'}, $row_ref->{'name'}, $row_ref->{'sex'}, $row_ref->{'created_at'}, $row_ref->{'updated_at'})."\n");
  }
  $sth->finish();
}

if ($0 eq __FILE__) {
  my $rdb = new MysqlManipulator();
  $rdb->dbconnect();
  $rdb->beginTransaction();
  $rdb->dropExampleTable();
  $rdb->createExampleTable();
  $rdb->createExampleData();
  $rdb->selectFromExampleTable();
  $rdb->dropExampleTable();
  $rdb->endTransaction();
  $rdb->dbclose();
}
else{
  1;
}