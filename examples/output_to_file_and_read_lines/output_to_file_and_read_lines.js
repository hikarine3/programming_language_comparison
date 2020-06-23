const fs = require('fs');
const readline = require('readline');
let output_file = "/tmp/output_js.txt";
let line_cnt = 0;
fs.writeFile(output_file, "Hello World!\n\nAdditional line\n", (err, resp) => {
  if (err) throw err;
  const fileStream = fs.createReadStream(output_file);
  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });
  rl.on('line', (line) => {
    console.log(`${line}`);
    line_cnt++;
  });
  rl.on('close', ()=>{console.log(line_cnt);});
});
