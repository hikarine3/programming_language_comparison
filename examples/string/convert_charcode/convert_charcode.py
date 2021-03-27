import urllib.parse
utf8str = "車"
eucstr = utf8str.encode('euc-jp')
print(urllib.parse.quote(eucstr))
print(eucstr.decode('euc-jp'))
