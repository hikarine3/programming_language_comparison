package SqliteManipulator;
use strict;
use DBI;

sub new() {
  my $self = {};
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
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  sex VARCHAR(15) DEFAULT NULL,
  created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
  updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
);
CREATE INDEX created_at_idx ON example(created_at);
CREATE INDEX name_idx ON example(name);
CREATE INDEX updated_at_idx ON example(updated_at);
EOF
  $self->executeSQL($sql);
}


sub dbclose(){
  my $self = shift;
  $self->{'rdbh'}->disconnect();
}

sub dbconnect(){
  my $self = shift;
  my $database = "example.sqlite";
  my $timezone = "Asia/Tokyo";
  $self->{'rdbh'} = DBI->connect("DBI:SQLite:database=".$database) or die "Failed to connect to db.";
  # my $sql = "SET TIME ZONE '".$timezone."'";
  # $self->{'rdbh'}->do($sql);
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
  my $sql = "SELECT id, name, sex, created_at, updated_at FROM example";
  my $sth = $self->{'rdbh'}->prepare($sql) or die("Failed to prepare ".$sql);
  $sth->execute() or die("Failed to execute ".$sql);
  while(my $row_ref = $sth->fetchrow_hashref) {
    print(join("\t", $row_ref->{'id'}, $row_ref->{'name'}, $row_ref->{'sex'}, $row_ref->{'created_at'}, $row_ref->{'updated_at'})."\n");
  }
  $sth->finish();
}

if ($0 eq __FILE__) {
  my $rdb = new SqliteManipulator();
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
