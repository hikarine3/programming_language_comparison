import urllib.parse

class JobnumChecker:
  def __init__(self, opt):
    print("Init")
    self.langs = ["アセンブリ", "C", "C#", "C++", "COBOL", "Go", "Java", "JavaScript", "Kotlin", "Object-C", "Perl", "PHP", "Python", "Ruby", "Scala", "Shell", "Swift", "Visual Basic"]

  def crawl(self):
    print("Crawl")
    self.jpIndeedCrawl()
    
  def jpIndeedCrawl(self):
    print("Start jpIndeedCrawl")
    for qry in self.langs:
      escapedQuery = urllib.parse.quote(qry)
      url = "https://jp.indeed.com/"+ escapedQuery+"-%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%E9%96%A2%E9%80%A3%E3%81%AE%E6%B1%82%E4%BA%BA"
      print(qry + "\t" + url)

if __name__ == "__main__":
  jc = JobnumChecker({ })
  jc.crawl()
