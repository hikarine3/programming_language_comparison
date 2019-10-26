class MySQL {
	constructor(opt={}) {
    this.mysql = require('mysql');
    require('dotenv').config();
    this.mdbh = this.mysql.createConnection({
      host: process.env.DBHOST,
      port: 3306,
      user: process.env.DBUSER,
      password: process.env.DBPASSWORD,
      database: 'mysql'
    });
  }

	dbconnect() {
    this.mdbh.connect(function (err) {
      if (err) {
          console.error('error connecting: ' + err.stack);
          return;
      }
    });
  }

	dbclose() {
    this.mdbh.end();
  }

  showSytemUsers() {
    const sql = "SELECT host,user,Select_priv FROM mysql.user";
    this.mdbh.query(sql, function (err, rows, fields) {
      if (err) { 
        console.log('err: ' + err);
      }
      for(let row of rows) {
        console.log([row.host, row.user, row.Select_priv].join("\t"));
      }
    });
  }
};
module.exports = MySQL;

if(!module.parent) {
	let rdb = new MySQL();
	rdb.dbconnect();
  rdb.showSytemUsers();
  rdb.dbclose();
}