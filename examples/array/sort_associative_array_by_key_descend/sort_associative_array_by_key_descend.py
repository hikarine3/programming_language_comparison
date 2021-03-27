example_array = {1: "January", 12:"December", 3:"March" }
tuples_sorted_by_key = sorted(example_array.items(), key=lambda x:x[0])[::-1]
for key, value in tuples_sorted_by_key:
  print(str(key) + " => " + value)
