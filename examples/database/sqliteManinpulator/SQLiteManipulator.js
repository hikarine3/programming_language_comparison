const fs = require('fs');
const fsExtra = require('fs-extra');

class SQLiteManipulator {
	constructor(opt={}) {
    this.dbname = '/tmp/example.sqlite';
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
 
    this.rdbh.serialize(() => {
      for (const data of datas) {
        const sql = 'INSERT INTO example (name, sex) VALUES (?, ?)';
        const params = [data[0], data[1]];
        this.rdbh.run(sql, params, (err) => {
          if (err) {
            return console.log(err.message);
          }
        }
        );
      }
    });
  }

  async createExampleTable() {
    const sqls = [`
    CREATE TABLE example (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(255) NOT NULL,
      sex VARCHAR(15) DEFAULT NULL,
      created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
      updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
    )`,
    'CREATE INDEX created_at_idx ON example(created_at)',
    'CREATE INDEX name_idx ON example(name)',
    'CREATE INDEX updated_at_idx ON example(updated_at)'
    ];
    this.rdbh.serialize(() => {
      for(const sql of sqls){
        this.executeSQL(sql);
      }
    });
  }

	async dbclose() {
    this.rdbh.serialize(() => {
      if (typeof(this.rdbh) !== "undefined") {
        this.rdbh.close();
      }
    });
  }

	async dbconnect() {
    if(fs.existsSync(this.dbname )) { 
      await fsExtra.remove(this.dbname );
    }
    var sqlite3 = require('sqlite3').verbose();
    this.rdbh = new sqlite3.Database(this.dbname);
  }

  async commit() {
    const sql = "END"
    this.rdbh.serialize(() => {
      this.executeSQL(sql)
    });
  }

  async executeSQL(sql) {
//    console.log(sql);
    try {
      const res = await this.rdbh.run(sql);
    }
    catch(err){
      const sql = "ROLLBACK"
      await this.rdbh.run(sql)
      console.log(err.name + ': ' + err.message);
    }
  }

  async selectFromExampleTable() {
    const sql = "SELECT id, name, sex, created_at, updated_at FROM example";
    try {
//      console.log(sql);
      this.rdbh.each(sql, function(err, row) {
        console.log([row.id, row.name, row.sex, row.created_at, row.updated_at].join("\t"))
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
module.exports = SQLiteManipulator

if(!module.parent) {
  (async () => {
    const rdb = new SQLiteManipulator()
    await rdb.dbconnect()
    await rdb.beginTransaction()
    await rdb.createExampleTable()
    await rdb.createExampleData()
    await rdb.selectFromExampleTable()
    await rdb.commit()
    await rdb.dbclose()
  })()
}
