<?php
$value = "This is target";
if (preg_match('/target/s', $value)) {
    print "Found target";
}