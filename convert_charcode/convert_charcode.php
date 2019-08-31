<?php
$utf8str = "車";
$eucstr = mb_convert_encoding( $utf8str, 'euc-jp', 'utf8');
print rawurlencode($eucstr)."\n";
$utf8str = $eucstr;
$utf8str = mb_convert_encoding( $utf8str, 'utf8', 'euc-jp');
print $utf8str."\n";
