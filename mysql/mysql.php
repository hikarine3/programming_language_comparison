<?php
require_once __DIR__ . '/vendor/autoload.php';

class MySQL {
  private $rdbh;
  public function __construct($opt=[]) {
    $dotenv = Dotenv\Dotenv::create(__DIR__);
    $dotenv->load();
    print("Loaded");
  }

  function dbconnect() {
    try {
      print implode("\t", [getenv('DBHOST'), getenv('DBUSER'), getenv('DBPASSWORD')]);
      $this->rdbh = new PDO('mysql:dbname=mysql;host='.getenv('DBHOST'), getenv('DBUSER'), getenv('DBPASSWORD'));
      $this->rdbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
      die("Failed to connect: ".$e->getMessage());
    }
  }

  function dbclose() {
    $this->rdbh = null;
  }

  function showSystemUsers() {
    $sth = $this->rdbh->prepare("SELECT host,user,Select_priv FROM mysql.user");
    $sth->execute();
    while($row = $sth->fetch(PDO::FETCH_ASSOC)){
      print(implode("\t", [$row['host'], $row['user'], $row['Select_priv']])."\n");
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $rdb = new MySQL();
  $rdb->dbconnect();
  $rdb->showSystemUsers();
  $rdb->dbclose();
}