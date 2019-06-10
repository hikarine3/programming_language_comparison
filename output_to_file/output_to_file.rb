output_file = "/tmp/output_ruby.txt"
File.open(output_file, "w") do |wfh|
    wfh.puts("Hello World!\n")
end

File.open(output_file, "r") do |rfh|
    print(rfh.read())
end
