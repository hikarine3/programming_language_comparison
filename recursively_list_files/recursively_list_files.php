<?php
if(isset($argv[1])) {
  $dir = $argv[1];
}
else {
  $dir = '.';
}
$it = new RecursiveDirectoryIterator($dir);
foreach(new RecursiveIteratorIterator($it) as $file) {
  if(!is_dir($file)) {
    print $file."\n";
  }
}