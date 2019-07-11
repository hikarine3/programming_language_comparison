output_file = "/tmp/output_ruby.txt"
begin
  File.open(output_file, "w") do |wfh|
    wfh.puts("Hello World!\nAdditional line\n")
  end
rescue SystemCallError => e
  puts "class=#{e.class},message=#{e.message}"
rescue IOError => e
  puts "class=#{e.class},message=#{e.message}"
end

File.open(output_file, "r") do |rfh|
  print(rfh.read())
end
