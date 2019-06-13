const fs = require('fs');
let file = "./input.json";
fs.readFile(file, (err, data) => {
if (err) throw err;
    const obj = JSON.parse(data.toString());
    for(const item of obj["items"]) {
        console.log(item["title"]);
    }
});
