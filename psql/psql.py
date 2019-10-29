from firstclass_dotenv import Dotenv
import psycopg2
import os

class Psql():
  def __init__(self, opt=[]):
    dotenv = Dotenv()
    dotenv.load()

  def beginTransaction(self):
    sql = "BEGIN"
    self.executeSQL(sql)

  def createExampleType(self):
    sql = "CREATE TYPE example_sex AS ENUM ('male', 'female')"
    self.executeSQL(sql)

  def createExampleTable(self):
    sql = '''\
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
    self.executeSQL(sql)

  def createExampleData(self):
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    with self.rdbh.cursor() as cur:
      for data in datas:
        cur.execute("INSERT INTO example (name, sex) VALUES (%s, %s)", [data[0], data[1]])

  def dbclose(self):
    self.rdbh.close()

  def dbconnect(self):
    dbname = "example"
    timezone = "Asia/Tokyo"
    self.rdbh = psycopg2.connect("host=" + os.environ['DBHOST'] +" port=5432 dbname=" + dbname + " user="+ os.environ['DBUSER'] + " password=" + os.environ['DBPASSWORD'])
    self.executeSQL("SET TIME ZONE '"+ timezone + "'")

  def dropExampleTable(self):
    sql = "DROP TABLE IF EXISTS example"
    self.executeSQL(sql)

  def dropExampleType(self):
    sql = "DROP TYPE IF EXISTS example_sex"
    self.executeSQL(sql)

  def endTransaction(self):
    self.rdbh.commit()

  def executeSQL(self, sql):
    with self.rdbh.cursor() as cur:
      cur.execute(sql)

  def rollback(self):
    self.rdbh.rollback()

  def selectFromExampleTable(self):
    sql = "SELECT id, name, sex, to_char(created_at, 'YYYY/MM/DD HH24:MI:SS') AS created_at, to_char(updated_at, 'YYYY/MM/DD HH24:MI:SS') AS updated_at FROM example"
    with self.rdbh.cursor() as cur:
      cur.execute(sql)
      for [id, name, sex, created_at, updated_at] in cur:
        print("\t".join([str(id), name, sex, str(created_at), str(updated_at)]))

if __name__ == "__main__":
  psql = Psql()
  psql.dbconnect()
  try:
    psql.beginTransaction()
    try:
      psql.dropExampleTable()
      psql.dropExampleType()
      psql.createExampleType()
      psql.createExampleTable()
      psql.createExampleData()
      psql.selectFromExampleTable()
      psql.dropExampleTable()
      psql.dropExampleType()
      psql.endTransaction()
    except Exception as e:
      psql.rollback()
      print(e)
    finally:
      psql.dbclose()
  except Exception as e:
    print(e)
  finally:
    psql.dbclose()
