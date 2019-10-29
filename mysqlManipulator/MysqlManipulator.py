from firstclass_dotenv import Dotenv
import mysql.connector
import os

class MysqlManipulator():
  def __init__(self, opt=[]):
    dotenv = Dotenv()
    dotenv.load()

  def beginTransaction(self):
    sql = "BEGIN"
    self.executeSQL(sql)

  def createExampleTable(self):
    sql = '''\
CREATE TABLE example (
  id int NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  sex ENUM('male', 'female') DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT NOW(),
  updated_at timestamp NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  KEY `created_at_idx` (`created_at`),
  KEY `name_idx` (`name`),
  KEY `updated_at_idx` (`updated_at`)
);
'''
    self.executeSQL(sql)

  def createExampleData(self):
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    for data in datas:
      self.cursor.execute("INSERT INTO example (name, sex) VALUES (%s, %s)", [data[0], data[1]])

  def dbclose(self):
    self.rdbh.close()

  def dbconnect(self):
    dbname = "example"
    timezone = "Asia/Tokyo"
    self.rdbh = mysql.connector.connect(host=os.environ['DBHOST'], user=os.environ['DBUSER'], passwd=os.environ['DBPASSWORD'], database=dbname)
    self.cursor = self.rdbh.cursor()
    self.executeSQL("SET TIME_ZONE = '"+ timezone + "'")

  def dropExampleTable(self):
    sql = "DROP TABLE IF EXISTS example"
    self.executeSQL(sql)

  def endTransaction(self):
    self.rdbh.commit()

  def executeSQL(self, sql):
    self.cursor.execute(sql)

  def rollback(self):
    self.rdbh.rollback()

  def selectFromExampleTable(self):
    sql = "SELECT id, name, sex, DATE_FORMAT(created_at, '%Y/%m/%d %H:%i:%S') AS created_at, DATE_FORMAT(updated_at, '%Y/%m/%d %H:%i:%S') AS updated_at FROM example"
    self.cursor.execute(sql)
    for [id, name, sex, created_at, updated_at] in self.cursor:
      print("\t".join([str(id), name, sex, str(created_at), str(updated_at)]))

if __name__ == "__main__":
  rdb = MysqlManipulator()
  rdb.dbconnect()
  try:
    rdb.beginTransaction()
    try:
      rdb.dropExampleTable()
      rdb.createExampleTable()
      rdb.createExampleData()
      rdb.selectFromExampleTable()
      rdb.dropExampleTable()
      rdb.endTransaction()
    except Exception as e:
      rdb.rollback()
      print(e)
    finally:
      rdb.dbclose()
  except Exception as e:
    print(e)
  finally:
    rdb.dbclose()
