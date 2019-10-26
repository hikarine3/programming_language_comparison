require 'dotenv'
require 'mysql2'

class MySQL
  def initialize(opt=[])
    Dotenv.load(
      File.join(File.dirname(File.expand_path(__FILE__)), '.env')
    )
  end

  def dbconnect
    @mdbh = Mysql2::Client.new(:host => ENV["DBHOST"], :username => ENV["DBUSER"], :password => ENV["DBPASSWORD"])
  end

  def showSystemUsers
    results = @mdbh.query("SELECT host,user,Select_priv FROM mysql.user")
    results.each do |row|
      print([row["host"], row['user'], row['Select_priv']].join("\t") + "\n")
    end
  end

  def dbclose
    @mdbh.close()
  end
end

if $0 == __FILE__
  rdb = MySQL.new()
  rdb.dbconnect()
  rdb.showSystemUsers()
  rdb.dbclose()
end
