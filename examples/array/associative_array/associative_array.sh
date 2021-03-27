#!/bin/sh
ARRAY=(
  ["1"]="January"
  ["2"]="February"
  ["3"]="March"
)

echo ${ARRAY["1"]}
echo ${ARRAY["2"]}
echo ${ARRAY["3"]}
