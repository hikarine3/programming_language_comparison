require 'fileutils'
root_dir = './example_directoy'
lang_dir = 'ruby'
dirpath = [root_dir, lang_dir].join("/")

FileUtils.mkdir_p(dirpath)

if Dir.exist?(dirpath)
  print("Succeeded in creation of " + dirpath + "\n")
  if root_dir.match("[a-zA-Z\d_\-]")
    FileUtils.remove_dir(root_dir)
    if !Dir.exist?(root_dir)
      print("Succeeded in removal of " + root_dir + "\n")
    end
  end
end