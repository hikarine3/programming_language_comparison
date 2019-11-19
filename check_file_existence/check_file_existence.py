import os
base_dir = os.path.dirname(__file__)
if not base_dir:
  base_dir = "."
exit_file = base_dir + '/a.txt'
not_exist_file = base_dir + '/b.txt'
if(os.path.exists(exit_file)):
  print("Found: " + exit_file)
if(not os.path.exists(not_exist_file)):
  print("Not Found: " + not_exist_file)
