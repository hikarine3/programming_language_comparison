const request = require('request');
const cheerio = require('cheerio');

let target_url = "https://www.yahoo.com/";
request(
    { method: 'GET', uri: target_url, gzip: true}, 
    function(err, res, content) {  
        const $ = cheerio.load(content);
        console.log($('title').text());
    }
);