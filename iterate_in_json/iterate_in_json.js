const fs = require('fs');
let file = "input_json.txt";
fs.readFile(file, (err, data) => {
if (err) throw err;
    process.stdout.write(data.toString());
});
