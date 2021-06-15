require 'sqlite3'

class SQLiteManipulator
  def initialize(opt=[])
    @dbname = "/tmp/example.sqlite"
  end

  def dbconnect
    timezone = "Asia/Tokyo"
    File.delete(@dbname)
    @rdbh = SQLite3::Database.new(@dbname)
  end

  def beginTransaction
    sql = "BEGIN"
    executeSQL(sql)
  end

  def createExampleType
    sql = "CREATE TYPE example_sex AS ENUM ('male', 'female')"
    executeSQL(sql)
  end

  def createExampleTable
    sqls = ["
    CREATE TABLE example (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(255) NOT NULL,
      sex VARCHAR(15) DEFAULT NULL,
      created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
      updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
    )",
    "CREATE INDEX created_at_idx ON example(created_at)",
    "CREATE INDEX name_idx ON example(name)",
    "CREATE INDEX updated_at_idx ON example(updated_at)"]
    sqls.each do |sql|
      executeSQL(sql)
    end
  end

  def createExampleData
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    datas.each do |data|
      @rdbh.execute("INSERT INTO example (name, sex) VALUES ($1, $2)", [data[0], data[1]])
    end
  end

  def dbclose
    @rdbh.close()
  end

  def commit
    sql = "END"
    @rdbh.query(sql)
  end

  def executeSQL(sql)
    @rdbh.query(sql)
  end

  def selectFromExampleTable
    sql = "SELECT id, name, sex, created_at, updated_at FROM example"
    results = @rdbh.query(sql)
    results.each do |row|
#      print([ row["id"].to_s(), row['name'], row['sex'], row['created_at'].to_s(), row['updated_at'].to_s() ].join("\t") + "\n")
      print(row.join("\t")+"\n")
    end
  end
end

if $0 == __FILE__
  pro = SQLiteManipulator.new()
  begin
    pro.dbconnect()
  rescue => err
    print(err)
    exit(1)
  end

  begin
    pro.beginTransaction()
    begin
      pro.createExampleTable()
      pro.createExampleData()
      pro.selectFromExampleTable()
      pro.commit()
    rescue => err
      puts("Automatically roll backed.")
      print(err)
      pro.dbclose()
      exit(1)
    end
  rescue => err
    pro.dbclose()
    print(err)
    exit(1)
  end
end
