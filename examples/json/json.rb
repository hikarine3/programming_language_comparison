require 'json'

file = "input.json"
json_str = ""
File.open(file, "r") do |rfh|
    json_str = rfh.read()
end
djson = JSON.parse(json_str)
for item in djson["items"]
    print(item["title"]+"\n")
end
