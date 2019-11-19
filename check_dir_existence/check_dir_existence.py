import os
base_dir = os.path.dirname(__file__)
if not base_dir:
  base_dir = "."
exit_dir = base_dir + '/a_dir'
not_exist_dir = base_dir + '/b_dir'
if(os.path.exists(exit_dir)):
  print("Found: " + exit_dir)
if(not os.path.exists(not_exist_dir)):
  print("Not Found: " + not_exist_dir)
