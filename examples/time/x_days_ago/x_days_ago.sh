#/bin/bash
date -d "02/01/2000" 2>: 1>:; VALID=$?;
if [ $VALID == 1 ]; then
  echo `date -d '2 days ago' '+%Y/%m/%d'`;
else
  echo `TZ=JST+48 date '+%Y/%m/%d'`;
fi
