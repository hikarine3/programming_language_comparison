<?php
$output_file = "/tmp/output_php.txt";
try {
  $fh = fopen($output_file, "w");
  fwrite($fh, "Hello World!\n\nAdditional line\n");
  fclose($fh);
}
catch (Exception $e) {
  echo $e->getMessage();
  exit;
}

$cnt = 0;
if($fh = fopen($output_file, "r") ){
  while($line = fgets($fh)) {
    print $line;
    $cnt++;
  }
  fclose($fh);
  print $cnt."\n";
}
