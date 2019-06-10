<?php
$file = __DIR__."/input.json";
$json_str = file_get_contents($file);
$djson = json_decode($json_str);
foreach($djson->items as $item){
    print($item->title."\n");
}