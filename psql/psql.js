class Psql {
	constructor(opt={}) {
    const { Pool, Client } = require('pg');
    require('dotenv').config();
    this.rdbh = new Client({
      host: process.env.DBHOST,
      port: 5432,
      user: process.env.DBUSER,
      password: process.env.DBPASSWORD,
      database: 'example'
    })
  }

  async beginTransaction() {
    const sql = "BEGIN"
    await this.executeSQL(sql)
  }

  async createExampleData() {
    const datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ];
    for (const data of datas) {
      const query = {
        text: 'INSERT INTO example (name, sex) VALUES ($1, $2)',
        values: [data[0], data[1]]
      }
      await this.executeSQL(query);
    }
  }

  async createExampleTable() {
    const sql = `
    CREATE TABLE example (
      id SERIAL NOT NULL,
      name VARCHAR(255) NOT NULL,
      sex example_sex DEFAULT NULL,
      created_at timestamp with time zone DEFAULT NOW(),
      updated_at timestamp with time zone DEFAULT NOW(),
      PRIMARY KEY (id)
    );
    CREATE INDEX created_at_idx ON example(created_at);
    CREATE INDEX name_idx ON example(name);
    CREATE INDEX updated_at_idx ON example(updated_at);
    `;
    await this.executeSQL(sql);
  }

  async createExampleType() {
    const sql = "CREATE TYPE example_sex AS ENUM ('male', 'female')";
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
    const sql = "SET TIME ZONE '"+ timezone +"'"
    await this.executeSQL(sql)
  }

  async dropExampleTable() {
    const sql = "DROP TABLE IF EXISTS example";
    await this.executeSQL(sql);
  }

  async dropExampleType() {
    const sql = "DROP TYPE IF EXISTS example_sex";
    await this.executeSQL(sql);
  }

  async endTransaction() {
    const sql = "END"
    await this.executeSQL(sql)
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
    const sql = "SELECT id, name, sex, to_char(created_at, 'YYYY/MM/DD HH24:MI:SS') AS created_at, to_char(updated_at, 'YYYY/MM/DD HH24:MI:SS') AS updated_at FROM example";
    try {
      const res = await this.rdbh.query(sql)
      for(const row of res.rows){
        console.log([row.id, row.name, row.sex, row.created_at, row.updated_at].join("\t"))
      }
    }
    catch(err) {
      const sql = "ROLLBACK"
      await this.executeSQL(sql)
      console.log(err.name + ': ' + err.message)
      process.exit(-1)
    }
  }
};
module.exports = Psql;

if(!module.parent) {
  (async () => {
    const rdb = new Psql()
    await rdb.dbconnect()
    await rdb.beginTransaction()
    await rdb.dropExampleTable()
    await rdb.dropExampleType()
    await rdb.createExampleType()
    await rdb.createExampleTable()
    await rdb.createExampleData()
    await rdb.selectFromExampleTable()
    await rdb.dropExampleTable()
    await rdb.dropExampleType()
    await rdb.endTransaction()
    await rdb.dbclose()
  })()
}
