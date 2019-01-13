const execSync = require('child_process').execSync;
const result =  execSync('ls').toString();
console.log(result);
