import os
class MkdirChmodRmdir:
  def __init__(self):
    self.dir = "python_dir"

  def run(self):
    if(not os.path.exists(self.dir)):
      os.mkdir(self.dir)
      print("mkdir")

    if(os.path.exists(self.dir)):
      print("chmod")
      os.chmod(self.dir, 0o777)

      print("rmdir")
      os.rmdir(self.dir)

if __name__ == '__main__':
  mcr = MkdirChmodRmdir()
  mcr.run()
