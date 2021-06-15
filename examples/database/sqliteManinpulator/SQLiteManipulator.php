<?php
//require_once __DIR__ . '/vendor/autoload.php';

class SQLiteManipulator {
  private $rdbh;
  public function __construct($opt=[]) {
    $this->dbname = '/tmp/example.sqlite';
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
    $sqls = ["
    CREATE TABLE example (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(255) NOT NULL,
      sex VARCHAR(15) DEFAULT NULL,
      created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
      updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
    )",
    "CREATE INDEX created_at_idx ON example(created_at)",
    "CREATE INDEX name_idx ON example(name)",
    "CREATE INDEX updated_at_idx ON example(updated_at)"
    ];
    foreach($sqls as $sql){
      $this->executeSQL($sql);
    }
  }

  function dbclose() {
    $this->rdbh = null;
  }
  
  function dbconnect(){
    if(file_exists($this->dbname)){
      unlink($this->dbname);
    }

    try {
      $this->rdbh = new PDO('sqlite:'.$this->dbname);
      $this->rdbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }
    catch (PDOException $e) {
      die("Failed to connect: ".$e->getMessage());
    }
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
    $sql = "SELECT id, name, sex, created_at, updated_at FROM example";
    $sth = $this->rdbh->prepare($sql);
    $sth->execute();
    while($row = $sth->fetch(PDO::FETCH_ASSOC)){
      print(implode("\t", [$row['id'], $row['name'], $row['sex'], $row['created_at'], $row['updated_at']])."\n");
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $rdb = new SQLiteManipulator();
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
    $rdb->createExampleTable();
    $rdb->createExampleData();
    $rdb->selectFromExampleTable();
    $rdb->endTransaction();
    $rdb->dbclose();
  } catch(PDOException $e){
    $rdb->rollback();
    $rdb->dbclose();
    throw $e;
  }
}