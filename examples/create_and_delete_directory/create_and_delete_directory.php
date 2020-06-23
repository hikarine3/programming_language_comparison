<?php
$root_dir = './example_directoy';
$lang_dir = 'php';
$dirpath = implode('/', [$root_dir, $lang_dir]);
if( !is_dir($dirpath) ) {
  mkdir($dirpath, 0777, true);
}
if( is_dir($dirpath) ) {
  print "Succeeded in creation of ".$dirpath."\n";
  if(preg_match('/[a-zA-Z\d_\-]/', $root_dir)) {
    delTree($root_dir);
  }
  if( !is_dir($root_dir) ) {
    print "Succeeded in removal of ".$root_dir."\n";
  }
}

function delTree($dir) { 
  $files = array_diff(scandir($dir), array('.','..')); 
   foreach ($files as $file) { 
     (is_dir("$dir/$file")) ? delTree("$dir/$file") : unlink("$dir/$file"); 
   } 
   return rmdir($dir); 
 } 