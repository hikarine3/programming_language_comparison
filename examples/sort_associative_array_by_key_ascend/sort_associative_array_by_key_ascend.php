<?php
$example_array = [1 => 'January', 12 => 'December', 3 => 'March'];
ksort($example_array);
foreach ($example_array as $key => $value) {
  echo $key . " => " . $value . "\n"; 
}
