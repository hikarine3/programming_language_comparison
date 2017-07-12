<?php
$output_file = "/tmp/output_php.txt";
$fh = fopen($output_file, "w") or die("Failed to open ".$output_file);
fwrite($fh, "Hello World!");
fclose($fh);

$fh = fopen($output_file, "r") or die("Failed to open ".$output_file);
while(!feof($fh)) {
  echo fgets($fh);
}
fclose($fh);

