base_dir=$(cd $(dirname $0); pwd);
exist_dir=$base_dir'/a_dir';
not_exist_dir=$base_dir'/b_dir';
if [ -d $exist_dir ]; then
  echo "Found: "$exist_dir;
fi
if [ ! -d $not_exist_dir ]; then
  echo "Not Found: "$not_exist_dir;
fi