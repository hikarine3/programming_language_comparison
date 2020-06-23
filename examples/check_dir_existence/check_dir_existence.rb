base_dir = File.dirname(__FILE__)
exit_dir = base_dir + '/a_dir'
not_exist_dir = base_dir + '/b_dir'
if(File.exist?(exit_dir)) 
  puts("Found: " + exit_dir)
end

if(!File.exist?(not_exist_dir)) 
  puts("Not Found: " + not_exist_dir);
end