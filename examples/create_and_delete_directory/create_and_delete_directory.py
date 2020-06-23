import os
import re
import shutil

root_dir = './example_directoy'
lang_dir = 'python'
dirpath = '/'.join([root_dir, lang_dir])
if not os.path.isdir(dirpath):
  os.makedirs(dirpath)

if os.path.isdir(dirpath):
  print("Succeeded in creation of " + dirpath)
  if re.search(r"[a-zA-Z\d_\-]", root_dir):
    shutil.rmtree(root_dir)
    if not os.path.isdir(root_dir):
      print("Succeeded in removal of " + root_dir)
