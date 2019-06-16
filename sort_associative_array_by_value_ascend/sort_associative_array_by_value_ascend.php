<?php
$example_array = ['January' => 1, 'December' => 12, 'March' => 3];
asort($example_array);
foreach ($example_array as $key => $value) {
  echo $key . " => " . $value . "\n"; 
}
