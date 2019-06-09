import subprocess
print(subprocess.check_output(["date"], shell=True).decode("UTF-8"))
