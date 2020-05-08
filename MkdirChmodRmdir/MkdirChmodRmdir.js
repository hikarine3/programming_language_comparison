class MkdirChmodRmdir {
  constructor(opt) {
    this.dir = 'js_dir';
    this.fs = require('fs')
  }

  run() {
    if(!this.fs.existsSync(this.dir)) { 
      console.log("mkdir");
      this.fs.mkdirSync(this.dir, { recursive: true }, (err) => {
        if (err) {
          throw err;
        }
      });
    }

    if(this.fs.existsSync(this.dir)) { 
      console.log("chmod");
      this.fs.chmodSync(this.dir, 0o777, (err) => {if(err){throw err;}});

      console.log("rmdir");
      this.fs.rmdirSync(this.dir, (err) => {if(err){throw err;}});
    }
  }
};

module.exports = MkdirChmodRmdir;

if(!module.parent) {
  let mcr = new MkdirChmodRmdir();
  mcr.run();
}
