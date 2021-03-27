<?php
$value = "This is target";
if (preg_match('/tar?get/s', $value)) {
    print "Found target\n";
}