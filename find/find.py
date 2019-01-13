import os
import sys
argvs = sys.argv 
if len(sys.argv) > 1:
	dir = argvs[1]
else:
	sys.exit("Please specify subdirectory")

print("Find in " + dir)
for root, dirs, files in os.walk(dir):
    for file in files:
#        if file.endswith(".py"):
        print(os.path.join(root, file))
