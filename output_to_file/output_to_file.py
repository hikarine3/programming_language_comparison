def main():
  output_file = "/tmp/output_python.txt"
  try:
    fh = open(output_file, "w") or die("Failed to write to " + output_file)
  except IOError:
    print("Failed to write to " + output_file)
    return

  fh.write("Hello World!")
  fh.close()

  fh = open(output_file, "r")
  print(fh.read())
  fh.close()

if __name__ == '__main__':
  main()
