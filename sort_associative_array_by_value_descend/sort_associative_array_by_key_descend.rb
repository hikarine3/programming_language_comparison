example_array = {"January" => 1, "December" => 12, "March" => 3 }
sorted_array = Hash[ example_array.sort_by{ |_, v| -v } ]
sorted_array.each { |tuple| print([tuple[0].to_s, tuple[1].to_s].join(" => ")+"\n") }
