from firstclass_dotenv import Dotenv
import mysql.connector
import os

class MySQL():
  def __init__(self, opt=[]):
    dotenv = Dotenv()
    dotenv.load()

  def dbconnect(self):
    self.mdbh = mysql.connector.connect(host=os.environ['DBHOST'], user=os.environ['DBUSER'], passwd=os.environ['DBPASSWORD'])

  def showSystemUsers(self):
    sql = "SELECT host,user,Select_priv FROM mysql.user"
    cur = self.mdbh.cursor()
    cur.execute(sql)
    for [host, user, selectPriv] in cur:
      print("\t".join([host.decode(), user.decode(), selectPriv]))
    cur.close()

  def dbclose(self):
    self.mdbh.close()

if __name__ == "__main__":
  rdb = MySQL()
  rdb.dbconnect()
  rdb.showSystemUsers()
  rdb.dbclose()
