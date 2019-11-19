<?php
$exist_dir = dirname(__FILE__).'/a_dir';
$not_exist_dir = dirname(__FILE__).'/b_dir';
if(file_exists($exist_dir) ) {
  print "Found: ".$exist_dir."\n";
}
if(!file_exists($not_exist_dir)) {
  print "Not Found: ".$not_exist_dir."\n";
}