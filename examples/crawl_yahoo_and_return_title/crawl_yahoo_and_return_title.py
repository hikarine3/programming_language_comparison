from pyquery import PyQuery

target_url = "https://www.yahoo.com/"
pq = PyQuery(url=target_url)
print(pq('title').text())