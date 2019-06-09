import sys
output_file = "/tmp/output_python.txt"
try:
  fh = open(output_file, "w") or die("Failed to write to " + output_file)
except IOError:
  print("Failed to write to " + output_file)
  sys.exit(1)

fh.write("Hello World!\n")
fh.close()

fh = open(output_file, "r")
print(fh.read(), end="")
fh.close()
