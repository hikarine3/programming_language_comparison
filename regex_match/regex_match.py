import re
value = "This is target"
if re.search( r'target', value ):
   print("Found target")