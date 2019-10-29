require 'dotenv'
require 'pg'

class Psql
  def initialize(opt=[])
    Dotenv.load(
      File.join(File.dirname(File.expand_path(__FILE__)), '.env')
    )
  end

  def dbconnect
    dbname = "example"
    timezone = "Asia/Tokyo"
    @rdbh = PG::connect(:host => ENV["DBHOST"], :user => ENV["DBUSER"], :password => ENV["DBPASSWORD"], :dbname => dbname)
    sql = "SET client_min_messages = 'error'"
    @rdbh.query(sql)
    sql = "SET TIME ZONE '"+ timezone + "'"
    @rdbh.query(sql)
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
    sql = '''
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
'''
    executeSQL(sql)
  end

  def createExampleData
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    datas.each do |data|
      @rdbh.exec_params("INSERT INTO example (name, sex) VALUES ($1, $2)", [data[0], data[1]])
    end
  end

  def dbclose
    @rdbh.close()
  end

  def dropExampleTable
    sql = "DROP TABLE IF EXISTS example"
    executeSQL(sql)
  end

  def dropExampleType
    sql = "DROP TYPE IF EXISTS example_sex"
    executeSQL(sql)
  end

  def endTransaction
    sql = "END"
    @rdbh.query(sql)
  end

  def executeSQL(sql)
    @rdbh.query(sql)
  end

  def selectFromExampleTable
    sql = "SELECT id, name, sex, to_char(created_at, 'YYYY/MM/DD HH24:MI:SS') AS created_at, to_char(updated_at, 'YYYY/MM/DD HH24:MI:SS') AS updated_at FROM example"
    results = @rdbh.query(sql)
    results.each do |row|
      print([row["id"], row['name'], row['sex'], row['created_at'], row['updated_at']].join("\t") + "\n")
    end
  end
end

if $0 == __FILE__
  rdb = Psql.new()
  begin
    rdb.dbconnect()
  rescue => err
    print(err)
    exit(1)
  end

  begin
    rdb.beginTransaction()
    begin
      rdb.dropExampleTable()
      rdb.dropExampleType()
      rdb.createExampleType()
      rdb.createExampleTable()
      rdb.createExampleData()
      rdb.selectFromExampleTable()
      rdb.dropExampleTable()
      rdb.dropExampleType()
      rdb.endTransaction()
    rescue => err
      puts("Automatically roll backed.")
      print(err)
      rdb.dbclose()
      exit(1)
    end
  rescue => err
    rdb.dbclose()
    print(err)
    exit(1)
  end
end
