#!/bin/bash
output_file="/tmp/output_shell.txt";
echo -e -n 'Hello World!\nAdditional line\n' > $output_file || exit 1;
cat $output_file;
