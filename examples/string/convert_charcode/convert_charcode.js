const iconv = require('iconv-lite')
const fs = require("fs");
let utf8str = "車"
let eucbuffer = iconv.encode(utf8str, 'eucjp')
console.log( [...eucbuffer ].map(n => `%${n.toString(16).toUpperCase()}`).join("") )
utf8str = iconv.decode(eucbuffer, 'eucjp')
console.log(utf8str)
