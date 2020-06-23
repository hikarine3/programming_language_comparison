<?php
if(file_exists($argv[1])){
  print(preg_replace('/\n/', "\t", file_get_contents($argv[1])));
}

