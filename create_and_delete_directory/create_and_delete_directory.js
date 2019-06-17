let fs = require("fs");
let fsExtra = require('fs-extra');
const root_dir = './example_directoy';
const lang_dir = 'js';
const dirpath = [root_dir, lang_dir].join("/");

fs.mkdir(dirpath, { recursive: true }, (err) => {
  if (err) {
    throw err;
  }
  else{
    console.log("Succeeded in creation of " + root_dir);
    if(root_dir.match(/[a-zA-Z\d_\-]/)) {
      fsExtra.remove(root_dir, (err) => {
        if (err) {
          throw err;
        }
        else{
          console.log("Succeeded in removal of " + root_dir);
        }
      });
    }
  }
});
