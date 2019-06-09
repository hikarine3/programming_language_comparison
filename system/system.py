import subprocess
result = subprocess.check_output(["date"], shell=True).decode("UTF-8")
print(result)
