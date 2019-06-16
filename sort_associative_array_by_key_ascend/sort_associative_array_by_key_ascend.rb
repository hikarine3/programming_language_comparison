example_array = {1 => "January", 12 => "December", 3 => "March" }
sorted_array = Hash[ example_array.sort ]
sorted_array.each { |tuple| print([tuple[0].to_s, tuple[1].to_s].join(" => ")+"\n") }
