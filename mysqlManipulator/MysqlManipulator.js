class MysqlManipulator {
	constructor(opt={}) {
    this.mysql = require('mysql');
    require('dotenv').config();
    this.rdbh = this.mysql.createConnection({
      host: process.env.DBHOST,
      user: process.env.DBUSER,
      password: process.env.DBPASSWORD,
      database: 'example'
    });
  }

  async beginTransaction() {
    const sql = "BEGIN"
    await this.executeSQL(sql)
  }

  async createExampleData() {
    const datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    const sql = 'INSERT INTO example (name, sex) VALUES (?, ?)'
    for (const data of datas) {
      const res = await this.rdbh.query(sql, data)
    }
  }

  async createExampleTable() {
    const sql = `CREATE TABLE example (
      id int NOT NULL AUTO_INCREMENT,
      name VARCHAR(255) NOT NULL,
      sex ENUM('male', 'female') DEFAULT NULL,
      created_at timestamp NOT NULL DEFAULT NOW(),
      updated_at timestamp NOT NULL DEFAULT NOW(),
      PRIMARY KEY (id),
      KEY created_at_idx (created_at),
      KEY name_idx (name),
      KEY updated_at_idx (updated_at)
    );`;
    await this.executeSQL(sql);
  }

	async dbclose() {
    if (typeof(this.rdbh) !== "undefined") {
      await this.rdbh.end();
    }
  }

	async dbconnect() {
    await this.rdbh.connect();
    const timezone = "Asia/Tokyo";
    const sql = "SET TIME_ZONE = '"+ timezone +"'"
    await this.executeSQL(sql)
  }

  async dropExampleTable() {
    const sql = "DROP TABLE IF EXISTS example";
    await this.executeSQL(sql);
  }

  async endTransaction() {
    await this.rdbh.commit()
  }

  async executeSQL(sql) {
    try {
      const res = await this.rdbh.query(sql);
    }
    catch(err){
      const sql = "ROLLBACK"
      await this.executeSQL(sql)
      console.log(err.name + ': ' + err.message);
    }
  }

  async selectFromExampleTable() {
    const sql = "SELECT id, name, sex, DATE_FORMAT(created_at, '%Y/%m/%d %H:%i:%S') AS created_at, DATE_FORMAT(updated_at, '%Y/%m/%d %H:%i:%S') AS updated_at FROM example";
    try {
      await this.rdbh.query(sql, function (err, rows, fields) {
        if (err) { 
          console.log('err: ' + err);
        }
        for(const row of rows){
          console.log([row.id, row.name, row.sex, row.created_at, row.updated_at].join("\t"))
        }
      });
    }
    catch(err) {
      const sql = "ROLLBACK"
      await this.executeSQL(sql)
      console.log(err.name + ': ' + err.message)
      process.exit(-1)
    }
  }
};
module.exports = MysqlManipulator;

if(!module.parent) {
  (async () => {
    const rdb = new MysqlManipulator()
    await rdb.dbconnect()
    await rdb.beginTransaction()
    await rdb.dropExampleTable()
    await rdb.createExampleTable()
    await rdb.createExampleData()
    await rdb.selectFromExampleTable()
    await rdb.dropExampleTable()
    await rdb.endTransaction()
    await rdb.dbclose()
  })()
}
