const request = require('request');
const cheerio = require('cheerio');
 
const target_url = "https://www.yahoo.com/";
request(
    { method: 'GET', uri: target_url, gzip: true}, 
    function(err, res, content) {  
        const $ = cheerio.load(content);
        console.assert($('title').text().toLowerCase().match("yahoo"), "yahoo is not included in title");
        console.log("OK");
    }
);