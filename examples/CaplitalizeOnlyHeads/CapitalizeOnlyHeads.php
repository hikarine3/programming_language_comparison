<?php
class CapitalizeOnlyHeads {
  public function __construct($opt = []){
  }
  public function convert($str="") {
    return ucwords($str);
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $capitalizer = new CapitalizeOnlyHeads;
  $str = " can you caplitalize?";
  print($capitalizer->convert($str)."\n");
}
