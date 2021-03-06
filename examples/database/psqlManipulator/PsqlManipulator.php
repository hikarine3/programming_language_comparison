<?php
require_once __DIR__ . '/vendor/autoload.php';

class PsqlManipulator {
  private $rdbh;
  public function __construct($opt=[]) {
    $dotenv = Dotenv\Dotenv::create(__DIR__);
    $dotenv->load();
  }

  function beginTransaction() {
    $this->rdbh->beginTransaction();
  }

  function createExampleData(){
    $datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ];
    $sql = "INSERT INTO example (name, sex) VALUES (?, ?)";
    $sth = $this->rdbh->prepare($sql);
    foreach($datas as $data) {
      $sth->execute([$data[0], $data[1]]);
    }
  }

  function createExampleTable(){
    $sql =  <<< EOF
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
EOF;
    $this->executeSQL($sql);
  }

  function createExampleType(){
    $sql = "CREATE TYPE example_sex AS ENUM ('male', 'female')";
    $this->executeSQL($sql);
  }

  function dbclose() {
    $this->rdbh = null;
  }
  
  function dbconnect(){
    $dbname = "example";
    $timezone = "Asia/Tokyo";
    try {
      $this->rdbh = new PDO('pgsql:dbname=example;host='.getenv('DBHOST'), getenv('DBUSER'), getenv('DBPASSWORD'));
      $this->rdbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }
    catch (PDOException $e) {
      die("Failed to connect: ".$e->getMessage());
    }
    $sql = "SET TIME ZONE '".$timezone."'";
    $this->executeSQL($sql);
  }

  function dropExampleTable() {
    $sql = "DROP TABLE IF EXISTS example";
    $this->executeSQL($sql);
  }

  function dropExampleType(){
    $sql = "DROP TYPE IF EXISTS example_sex";
    $this->executeSQL($sql);
  }

  function endTransaction(){
    $this->rdbh->commit();
  }

  function executeSQL($sql) {
    $sqls = explode(';', $sql);
    foreach ($sqls as $sql) {
      if($sql) {
        $sth = $this->rdbh->prepare($sql);
        $sth->execute();
      }
    }
  }

  function rollback(){
    $this->rdbh->rollback();
  }
  
  function selectFromExampleTable(){
    $sql = "SELECT id, name, sex, to_char(created_at, 'YYYY/MM/DD HH24:MI:SS') AS created_at, to_char(updated_at, 'YYYY/MM/DD HH24:MI:SS') AS updated_at FROM example";
    $sth = $this->rdbh->prepare($sql);
    $sth->execute();
    while($row = $sth->fetch(PDO::FETCH_ASSOC)){
      print(implode("\t", [$row['id'], $row['name'], $row['sex'], $row['created_at'], $row['updated_at']])."\n");
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $pro = new PsqlManipulator();
  try{
    $pro->dbconnect();
  } catch(PDOException $e){
    echo $e->getMessage();
    exit(1);
  }

  try{
    $pro->beginTransaction();
  } catch(PDOException $e){
    echo $e->getMessage();
    $pro->dbclose();
    exit(1);
  }

  try {
    $pro->dropExampleTable();
    $pro->dropExampleType();
    $pro->createExampleType();
    $pro->createExampleTable();
    $pro->createExampleData();
    $pro->selectFromExampleTable();
    $pro->dropExampleTable();
    $pro->dropExampleType();
    $pro->endTransaction();
    $pro->dbclose();
  } catch(PDOException $e){
    $pro->rollback();
    $pro->dbclose();
    throw $e;
  }
}