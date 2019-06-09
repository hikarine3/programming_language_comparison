const execSync = require('child_process').execSync;
let result = execSync('date').toString();
console.log(result);
