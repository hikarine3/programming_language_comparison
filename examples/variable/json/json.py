import json

file = "./input.json"
fh = open(file, "r")
json_str = fh.read()
fh.close()
djson = json.load(json_str)
for item in djson["items"]:
    print(item["title"])
