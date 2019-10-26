require 'find'
dir = ""
if ARGV[0]
  dir = ARGV[0]
else
  dir = "."
end

Find.find(dir) do |file|
  if File.file?(file)
    puts(file)
  end
end
