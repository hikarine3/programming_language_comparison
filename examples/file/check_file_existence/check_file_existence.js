const fs = require('fs')
base_dir = __dirname
const exist_file = base_dir + '/a.txt'
const not_exist_file = base_dir + '/b.txt'
if(fs.existsSync(exist_file)) { 
  console.log("Found: " + exist_file)
}
if(!fs.existsSync(not_exist_file)) { 
  console.log("Not Found: " + not_exist_file);
}