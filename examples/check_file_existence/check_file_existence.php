<?php
$exist_file = dirname(__FILE__).'/a.txt';
$not_exist_file = dirname(__FILE__).'/b.txt';
if(file_exists($exist_file) ) {
  print "Found: ".$exist_file."\n";
}
if(!file_exists($not_exist_file)) {
  print "Not Found: ".$not_exist_file."\n";
}