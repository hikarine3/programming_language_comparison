var recursive = require("recursive-readdir");
let dir = ".";
if(typeof(process.argv[2]) !== "undefined"){
  dir = process.argv[2];
}
else{
  dir = ".";
}
recursive(dir, function (err, files) {
  for(const i in files) {
    console.log(files[i]);
  }
});
