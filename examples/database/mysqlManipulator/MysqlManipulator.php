<?php
require_once __DIR__ . '/vendor/autoload.php';

class MysqlManipulator {
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
EOF;
    $this->executeSQL($sql);
  }

  function dbclose() {
    $this->rdbh = null;
  }
  
  function dbconnect(){
    $dbname = "example";
    $timezone = "Asia/Tokyo";
    try {
      $this->rdbh = new PDO('mysql:dbname='.$dbname.';host='.getenv('DBHOST'), getenv('DBUSER'), getenv('DBPASSWORD'));
      $this->rdbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }
    catch (PDOException $e) {
      die("Failed to connect: ".$e->getMessage());
    }
    $sql = "SET TIME_ZONE = '".$timezone."'";
    $this->executeSQL($sql);
  }

  function dropExampleTable() {
    $sql = "DROP TABLE IF EXISTS example";
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
  
  function selectFromExampleTable(){
    $sql = "SELECT id, name, sex, DATE_FORMAT(created_at, '%Y/%m/%d %H:%i:%S') AS created_at, DATE_FORMAT(updated_at, '%Y/%m/%d %H:%i:%S') AS updated_at FROM example";
    $sth = $this->rdbh->prepare($sql);
    $sth->execute();
    while($row = $sth->fetch(PDO::FETCH_ASSOC)){
      print(implode("\t", [$row['id'], $row['name'], $row['sex'], $row['created_at'], $row['updated_at']])."\n");
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $rdb = new MysqlManipulator();
  try{
    $rdb->dbconnect();
  } catch(PDOException $e){
    echo $e->getMessage();
    exit(1);
  }

  try{
    $rdb->beginTransaction();
  } catch(PDOException $e){
    echo $e->getMessage();
    $rdb->dbclose();
    exit(1);
  }

  try {
    $rdb->dropExampleTable();
    $rdb->createExampleTable();
    $rdb->createExampleData();
    $rdb->selectFromExampleTable();
    $rdb->dropExampleTable();
    $rdb->endTransaction();
    $rdb->dbclose();
  } catch(PDOException $e){
    $rdb->rollback();
    $rdb->dbclose();
    throw $e;
  }
}