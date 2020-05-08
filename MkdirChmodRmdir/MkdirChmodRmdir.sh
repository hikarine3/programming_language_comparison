#!/bin/sh
DIR="shell_dir"
 
if [ -d $DIR ]; then
  :
else
  echo "mkdir";
  mkdir $DIR;
fi
 
if [ -d $DIR ]
then
  echo "chmod";
  chmod 777 $DIR;
 
  echo "rmdir";
  rmdir $DIR;
fi