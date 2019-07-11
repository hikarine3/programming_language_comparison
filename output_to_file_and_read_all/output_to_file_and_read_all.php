<?php
$output_file = "/tmp/output_php.txt";
try {
  $fh = fopen($output_file, "w");
  fwrite($fh, "Hello World!\nAdditional line\n");
  fclose($fh);
}
catch (Exception $e) {
  echo $e->getMessage();
  exit;
}

print file_get_contents($output_file);
