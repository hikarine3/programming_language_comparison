from pyquery import PyQuery
import re

target_url = "https://www.yahoo.com/"
pq = PyQuery(url=target_url)
assert re.search(r"Yahoo", pq('title').text(), re.IGNORECASE), "yahoo is not included in title"
print("OK")
