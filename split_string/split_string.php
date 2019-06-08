<?php
$str = 'a,b,c';
$array = explode(',',$str);
foreach ($array as $elem) {
    print $elem."\n";
}
