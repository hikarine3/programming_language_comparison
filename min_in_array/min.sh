#!/bin/sh
array=(3 1 2)
min=${array[0]}
for i in ${array[@]}
do
    if [ ${i} -lt $min ]; then
        min=${i}
    fi
done
echo $min;
