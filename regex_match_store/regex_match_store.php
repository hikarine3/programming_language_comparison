<?php
$value = "This is target 1.
Name is apple.
Target 2 is here. 
Name is orange.";
$matches = [];
preg_match_all('/target\s([\d+]).*?Name\s+is\s+([^\.]+)\./is', $value, $matches);
if(isset($matches[1])) {
    $i = 0;
    foreach($matches[1] as $match) {
        print($match."=".$matches[2][$i]."\n");
        $i++;
    }
}
