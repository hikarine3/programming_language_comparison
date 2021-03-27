<?php
class MkdirChmodRmdir {
  public function __construct($opt = []){
    $this->dir = 'php_dir';
  }

  public function run() {
    if(!file_exists($this->dir)) {
      print "mkdir\n";
      mkdir($this->dir);
    }

    if(file_exists($this->dir)) {
      print "chmod\n";
      chmod($this->dir, 0777);

      print "rmdir\n";
      rmdir($this->dir);
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $mcr = new MkdirChmodRmdir();
  $mcr->run();
}