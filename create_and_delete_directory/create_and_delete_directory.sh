ROOTDIR='./example_directoy';
LANGDIR='python';
DIRPATH=$ROOTDIR'/'$LANGDIR;
mkdir -p $DIRPATH;

if [ -d $DIRPATH ]
then
  echo "Succeeded in creation of ".$DIRPATH;
fi

if [[ $DIRPATH =~ [a-zA-Z\d_\-] ]]
then
  rm -r $ROOTDIR;
fi

if [ ! -d $ROOTDIR ]
then
  echo "Succeeded in removal of ".$ROOTDIR;
else
  echo "Failed in removal of ".$ROOTDIR;
fi
