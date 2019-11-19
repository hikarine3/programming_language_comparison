const fs = require('fs')
base_dir = __dirname
const exist_dir = base_dir + '/a_dir'
const not_exist_dir = base_dir + '/b_dir'
if(fs.existsSync(exist_dir)) { 
  console.log("Found: " + exist_dir)
}
if(!fs.existsSync(not_exist_dir)) { 
  console.log("Not Found: " + not_exist_dir)
}