import sys
def main():
  argvs = sys.argv
  argc = len(argvs)
  file = ""
  if argc >= 2 and argvs[1]:
    file = argvs[1]

  if file == "":
    sys.exit("Please specify input file name");

  try:
    fh = open(file)
  except IOError:
    print("Failed to open " + file)
    return
  con = fh.read()
  print(con.replace("\n", "\t"))

if __name__ == '__main__':
  main()

