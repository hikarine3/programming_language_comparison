#!/bin/sh
output_file="/tmp/output_shell.txt";
echo "Hello World!\n" > $output_file;
CONTENT=$(<$output_file)
echo $CONTENT;
