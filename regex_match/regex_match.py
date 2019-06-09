import re
value = "This is target"
if re.search( r'tar?get', value ):
   print("Found target")
