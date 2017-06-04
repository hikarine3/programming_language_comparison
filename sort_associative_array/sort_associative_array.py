import collections
example_array = {1: "Janualry", 12:"December", 3:"March" }
example_array2 = collections.OrderedDict(sorted(example_array.items(), key=lambda t: t[0]))
for key, value in example_array2.items():
  print(str(key) + " => " + value)

