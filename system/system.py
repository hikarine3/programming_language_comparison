import subprocess
print(subprocess.check_output(["ls"], shell=True).decode("UTF-8"))
