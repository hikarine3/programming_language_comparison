import sys
output_file = "/tmp/output_python.txt"
try:
  with open(output_file, "w") as wfh:
    wfh.write("Hello World!\n\nAdditional line\n")
except IOError:
  print("Failed to write to " + output_file)
  sys.exit(1)
except:
  print("Unexpected error:", sys.exc_info()[0])
  sys.exit(1)

line_cnt = 0
with open(output_file, "r") as rfh:
  for line in rfh:
    print(line.rstrip("\n"))
    line_cnt += 1
print(line_cnt)
