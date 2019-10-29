package Psql;
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

sub createExampleTable() {
  my $self = shift;
  my $sql = <<EOF;
CREATE TABLE example (
  id SERIAL NOT NULL,
  name VARCHAR(255) NOT NULL,
  sex example_sex DEFAULT NULL,
  created_at timestamp with time zone DEFAULT NOW(),
  updated_at timestamp with time zone DEFAULT NOW(),
  PRIMARY KEY (id)
);
CREATE INDEX created_at_idx ON example(created_at);
CREATE INDEX name_idx ON example(name);
CREATE INDEX updated_at_idx ON example(updated_at);
EOF
  $self->executeSQL($sql);
}

sub createExampleType() {
  my $self = shift;
  my $sql = "CREATE TYPE example_sex AS ENUM ('male', 'female')";
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

sub dbconnect(){
  my $self = shift;
  my $database = "example";
  my $timezone = "Asia/Tokyo";
  $self->{'rdbh'} = DBI->connect("DBI:Pg:database=".$database.";host=".$ENV{'DBHOST'}, $ENV{'DBUSER'}, $ENV{'DBPASSWORD'}, {
   AutoCommit => 0,
   PrintError => 1,
   PrintWarn => 0
   }) or die "Failed to connect to db.";
  my $sql = "SET TIME ZONE '".$timezone."'";
  $self->{'rdbh'}->do($sql);
}

sub dbclose(){
  my $self = shift;
  $self->{'rdbh'}->disconnect();
}

sub executeSQL(){
  my $self = shift;
  my $sql = shift;
  $self->{'rdbh'}->do($sql);
}

sub dropExampleTable(){
  my $self = shift;
  my $sql = "DROP TABLE IF EXISTS example";
  $self->executeSQL($sql);
}

sub dropExampleType(){
  my $self = shift;
  my $sql = "DROP TYPE IF EXISTS example_sex";
  $self->executeSQL($sql);
}

sub endTransaction(){
  my $self = shift;
  $self->{'rdbh'}->commit();
}

sub selectFromExampleTable(){
  my $self = shift;
  my $sql = "SELECT id, name, sex, to_char(created_at, 'YYYY/MM/DD HH24:MI:SS') AS created_at, to_char(updated_at, 'YYYY/MM/DD HH24:MI:SS') AS updated_at FROM example";
  my $sth = $self->{'rdbh'}->prepare($sql);
  $sth->execute();
  while(my $row_ref = $sth->fetchrow_hashref) {
    print(join("\t", $row_ref->{'id'}, $row_ref->{'name'}, $row_ref->{'sex'}, $row_ref->{'created_at'}, $row_ref->{'updated_at'})."\n");
  }
  $sth->finish();
}

if ($0 eq __FILE__) {
  my $rdb = new Psql();
  $rdb->dbconnect();
  $rdb->beginTransaction();
  $rdb->dropExampleTable();
  $rdb->dropExampleType();
  $rdb->createExampleType();
  $rdb->createExampleTable();
  $rdb->createExampleData();
  $rdb->selectFromExampleTable();
  $rdb->dropExampleTable();
  $rdb->dropExampleType();
  $rdb->endTransaction();
  $rdb->dbclose();
}
else{
  1;
}