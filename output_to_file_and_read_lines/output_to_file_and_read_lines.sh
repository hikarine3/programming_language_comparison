#!/bin/bash
output_file="/tmp/output_shell.txt";
echo -e -n 'Hello World!\n\nAdditional line\n' > $output_file || exit 1;
line_cnt=0;
while IFS= read -r line
do
  echo "$line"
  line_cnt=$((line_cnt + 1))
done <"$output_file"
echo $line_cnt;
