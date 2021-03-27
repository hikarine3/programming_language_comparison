#/bin/sh
date -d "02/01/2000" 2>: 1>:; INVALID=$?;
if [ $INVALID == 1 ]; then
  echo `TZ=JST+48 date '+%Y/%m/%d'`;
else
  echo `date -d '2 days ago' '+%Y/%m/%d'`;
fi
