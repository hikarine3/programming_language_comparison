#!/bin/sh
array=(3 1 2)
max=${array[0]}
for i in ${array[@]}
do
    if [ ${i} -gt $max ]; then
        max=${i}
    fi
done
echo $max;
