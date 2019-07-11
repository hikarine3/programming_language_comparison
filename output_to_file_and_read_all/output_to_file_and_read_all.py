import sys
output_file = "/tmp/output_python.txt"
try:
  with open(output_file, "w") as wfh:
    wfh.write("Hello World!\nAdditional line\n")
except IOError:
  print("Failed to write to " + output_file)
  sys.exit(1)
except:
  print("Unexpected error:", sys.exc_info()[0])
  sys.exit(1)

with open(output_file, "r") as rfh:
  print(rfh.read(), end="")
