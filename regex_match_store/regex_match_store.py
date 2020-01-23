import re
value = """This is target 1.
Name is apple.
Target 2 is here. 
Name is orange."""
matches = re.findall( r'target\s([\d+]).*?Name\s+is\s+([^\.]+)\.', value, re.IGNORECASE | re.DOTALL)
for match in matches:
  print(match[0]+"="+match[1])
