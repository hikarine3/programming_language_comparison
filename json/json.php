<?php
$file = "input.json";
$json_str = readfile($file);
var_dump($json_str);
$decoded_json = json_decode($json_str);
var_dump($decoded_json);

