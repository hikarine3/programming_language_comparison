output_file = "/tmp/output_ruby.txt"
begin
  File.open(output_file, "w") do |wfh|
    wfh.puts("Hello World!\n\nAdditional line\n")
  end
rescue SystemCallError => e
  puts "class=#{e.class},message=#{e.message}"
rescue IOError => e
  puts "class=#{e.class},message=#{e.message}"
end

line_cnt = 0
File.open(output_file, "r") do |rfh|
  while (line = rfh.gets)
    puts line
    line_cnt += 1
  end
end

puts line_cnt
