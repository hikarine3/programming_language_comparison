import sys
from os import walk
import os
import re

path = ""

try:
  sys.argv[1]
except:
  path = "."
else:
  path = sys.argv[1]

def find_files(dir):
  for root, dirs, files in walk(path):
    for file in files:
      if os.path.isdir(file):
        find_files(file)
      else:
        print(root, end = '')
        if not re.search(r"/$", root):
          print("/", end = "")
        else:
          pass
        print(file)
find_files(path)
