require 'dotenv'
require 'mysql2'

class MysqlManipulator
  def initialize(opt=[])
    Dotenv.load(
      File.join(File.dirname(File.expand_path(__FILE__)), '.env')
    )
  end

  def dbconnect
    dbname = "example"
    timezone = "Asia/Tokyo"
    @rdbh = Mysql2::Client.new(:host => ENV["DBHOST"], :username => ENV["DBUSER"], :password => ENV["DBPASSWORD"], :database => dbname)
    sql = "SET TIME_ZONE = '"+ timezone + "'"
    @rdbh.query(sql)
  end

  def beginTransaction
    sql = "BEGIN"
    executeSQL(sql)
  end

  def createExampleTable
    sql = '''
CREATE TABLE example (
  id int NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  sex ENUM("male", "female") DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT NOW(),
  updated_at timestamp NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  KEY created_at_idx (created_at),
  KEY name_idx (name),
  KEY updated_at_idx (updated_at)
);
'''
    executeSQL(sql)
  end

  def createExampleData
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    sth = @rdbh.prepare("INSERT INTO example (name, sex) VALUES (?, ?)")
    datas.each do |data|
      sth.execute(data[0], data[1])
    end
  end

  def dbclose
    @rdbh.close()
  end

  def dropExampleTable
    sql = "DROP TABLE IF EXISTS example"
    executeSQL(sql)
  end

  def endTransaction
    sql = "COMMIT"
    @rdbh.query(sql)
  end

  def executeSQL(sql)
    @rdbh.query(sql)
  end

  def selectFromExampleTable
    sql = "SELECT id, name, sex, DATE_FORMAT(created_at, '%Y/%m/%d %H:%i:%S') AS created_at, DATE_FORMAT(updated_at, '%Y/%m/%d %H:%i:%S') AS updated_at FROM example"
    results = @rdbh.query(sql)
    results.each do |row|
      print([row["id"], row['name'], row['sex'], row['created_at'], row['updated_at']].join("\t") + "\n")
    end
  end
end

if $0 == __FILE__
  rdb = MysqlManipulator.new()
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
      rdb.createExampleTable()
      rdb.createExampleData()
      rdb.selectFromExampleTable()
      rdb.dropExampleTable()
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
