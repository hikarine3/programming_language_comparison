<?php
$example_array = [1 => 'January', 12 => 'December', 3 => 'March'];
krsort($example_array);
foreach ($example_array as $key => $value) {
  echo $key . " => " . $value . "\n"; 
}
