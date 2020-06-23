example_array = {"January":1, "December":12, "March":3 }
tuples_sorted_by_key = sorted(example_array.items(), key=lambda x:x[1])
for key, value in tuples_sorted_by_key:
  print(key + " => " + str(value))
