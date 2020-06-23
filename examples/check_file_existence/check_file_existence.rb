base_dir = File.dirname(__FILE__)
exit_file = base_dir + '/a.txt'
not_exist_file = base_dir + '/b.txt'
if(File.exist?(exit_file)) 
  puts("Found: " + exit_file)
end

if(!File.exist?(not_exist_file)) 
  puts("Not Found: " + not_exist_file);
end