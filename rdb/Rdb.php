<?php
require_once __DIR__ . '/vendor/autoload.php';

class Rdb {
  private $mdbh;
  public function __construct($opt=[]) {
    $dotenv = Dotenv\Dotenv::create(__DIR__);
    $dotenv->load();
    print("Loaded");
  }

  function dbconnect() {
    try {
      print implode("\t", [getenv('DBHOST'), getenv('DBUSER'), getenv('DBPASSWORD')]);
      $this->mdbh = new PDO('mysql:dbname=mysql;host='.getenv('DBHOST'), getenv('DBUSER'), getenv('DBPASSWORD'));
      $this->mdbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
      die("Failed to connect: ".$e->getMessage());
    }
  }

  function dbclose() {
    $this->mdbh = null;
  }

  function showSystemUsers() {
    $sth = $this->mdbh->prepare("SELECT host,user,Select_priv FROM mysql.user");
    $sth->execute();
    while($row = $sth->fetch(PDO::FETCH_ASSOC)){
      print(implode("\t", [$row['host'], $row['user'], $row['Select_priv']])."\n");
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $rdb = new Rdb();
  $rdb->dbconnect();
  $rdb->showSystemUsers();
  $rdb->dbclose();
}
