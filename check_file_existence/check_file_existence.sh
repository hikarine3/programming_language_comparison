base_dir=$(cd $(dirname $0); pwd);
exist_file=$base_dir'/a.txt';
not_exist_file=$base_dir'/b.txt';
if [ -f $exist_file ]; then
  echo "Found: "$exist_file;
fi
if [ ! -f $not_exist_file ]; then
  echo "Not Found: "$not_exist_file;
fi