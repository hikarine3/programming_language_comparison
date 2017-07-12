// Async write
const fs = require('fs');
let output_file = "/tmp/output_js.txt";
fs.writeFile(output_file, "Hello World!", (err, resp) => {
    if (err) throw err;
    fs.readFile(output_file, (err, data) => {
	if (err) throw err;
        console.log(data.toString());
    });
});

