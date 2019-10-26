from firstclass_dotenv import Dotenv
import psycopg2
import os

class Psql():
  def __init__(self, opt=[]):
    dotenv = Dotenv()
    dotenv.load()

  def dbconnect(self):
    dbname = "example"
    self.rdbh = psycopg2.connect("host=" + os.environ['DBHOST'] +" port=5432 dbname=" + dbname + " user="+ os.environ['DBUSER'] + " password=" + os.environ['DBPASSWORD'])

  def executeSimpleSQL(self, sql):
    with self.rdbh.cursor() as cur:
      cur.execute(sql)

  def dropExampleTable(self):
    sql = "DROP TABLE example"
    print(sql)
    self.executeSimpleSQL(sql)

  def createExampleTable(self):
    sql = "CREATE TYPE sex AS ENUM ('male', 'female');CREATE TABLE example (id SERIAL NOT NULL, name VARCHAR(255) NOT NULL, sex sex DEFAULT NULL, created_at timestamp DEFAULT NOW(), updated_at timestamp DEFAULT NOW(), PRIMARY KEY (id));"
    print(sql)
    self.executeSimpleSQL(sql)

  def createExampleData(self):
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    with self.rdbh.cursor() as cur:
      for data in datas:
        print(data[1])
        cur.execute("INSERT INTO example (name, sex) VALUES (%s, %s)", [data[0], data[1]])

  def selectFromExampleTable(self):
    sql = "SELECT id, name, sex, DATE_TRUNC('sec', created_at), DATE_TRUNC('sec', updated_at) FROM example"
    print(sql)
    with self.rdbh.cursor() as cur:
      cur.execute(sql)
      for [id, name, sex, created_at, updated_at] in cur:
        print("\t".join([str(id), name, sex, str(created_at), str(updated_at)]))

  def dbclose(self):
    self.rdbh.close()

if __name__ == "__main__":
  psql = Psql()
  psql.dbconnect()
  psql.createExampleTable()
  psql.createExampleData()
  psql.selectFromExampleTable()
  psql.dropExampleTable()
  psql.dbclose()
