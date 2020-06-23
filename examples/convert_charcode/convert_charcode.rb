require 'uri'
utfstr = "車"
eucstr = utfstr.encode("EUC-JP")
print(URI.escape(eucstr)+"\n")
utfstr = eucstr.encode("UTF-8", "EUC-JP")
print(utfstr+"\n")