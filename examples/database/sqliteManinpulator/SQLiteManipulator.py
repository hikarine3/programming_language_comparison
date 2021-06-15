import sqlite3
import os
from pprint import pprint

class SQLiteManipulator():
  def __init__(self, opt=[]):
    self.dbfile = '/tmp/example.sqlite'
    pass

  def beginTransaction(self):
    sql = "BEGIN"
    self.executeSQL(sql)

  def createExampleTable(self):
    sqls = ['''\
CREATE TABLE example (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(255) NOT NULL,
  sex VARCHAR(15) DEFAULT NULL,
  created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
  updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
)
''',
      'CREATE INDEX created_at_idx ON example(created_at)',
      'CREATE INDEX name_idx ON example(name)',
      'CREATE INDEX updated_at_idx ON example(updated_at)'
    ]
    for sql in sqls:
      self.executeSQL(sql)

  def createExampleData(self):
    datas = [
      ['name1', 'male'],
      ['name2', 'female']
    ]
    cur = self.rdbh.cursor()
    for data in datas:
      try:
        cur.execute("INSERT INTO example (name, sex) VALUES (?, ?)", [data[0], data[1]])          
      except Exception as e:
        pro.rollback()
        print(e)

  def dbclose(self):
    self.rdbh.commit()
    self.cur.close()
    self.rdbh.close()

  def dbconnect(self):
    if os.path.exists(self.dbfile):
      os.remove(self.dbfile)
    self.rdbh = sqlite3.connect(self.dbfile)
    self.cur = self.rdbh.cursor()

  def commit(self):
    self.rdbh.commit()

  def executeSQL(self, sql):
    cur = self.rdbh.cursor()
    try:
      cur.execute(sql)
    except Exception as e:
      pro.rollback()
      print(e)

  def rollback(self):
    self.rdbh.rollback()

  def selectFromExampleTable(self):
    sql = "SELECT id, name, sex, created_at, updated_at FROM example"
    self.cur.execute(sql)
    for [id, name, sex, created_at, updated_at] in self.cur:
      print("\t".join([str(id), name, sex, str(created_at), str(updated_at)]))

if __name__ == "__main__":
  pro = SQLiteManipulator()
  pro.dbconnect()
  pro.beginTransaction()
  try:
    pro.createExampleTable()
    pro.createExampleData()
    pro.selectFromExampleTable()
    pro.commit()
    pro.dbclose()
  except Exception as e:
    pro.rollback()
    pro.dbclose()
    print(e)

