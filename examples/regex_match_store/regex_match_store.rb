value = "This is target 1.
Name is apple.
Target 2 is here. 
Name is orange.";
matches = value.scan(/target\s([\d+]).*?Name\s+is\s+([^\.]+)\./im)
for match in matches do
  puts(match[0]+"="+match[1])
end
