file = "/tmp/output_python.xt"
fh = open(file, "w")
fh.write("Hello World!")
fh.close()

fh = open(file, "r")
print(fh.read())
fh.close()

