require 'uri'
orig = "toyota%20%E8%BB%8A"
print URI.unescape(orig) + "\n"
