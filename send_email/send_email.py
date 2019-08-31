import smtplib
from email.mime.text import MIMEText
from email.header import Header
from email import charset

import re
import sys

class Mailer:
  def help(self):
    print("Example:")
    print("python3 send_email.py --from_email=... --to_email=... --from=... --cc=... --bcc=... --subject=... --body=... --smtp_server=... --smtp_port=... --smtp_user=... --smtp_password=...")
    sys.exit(0)

  def __init__(self, opt):
    self.debug = False
    self.smtp_server = "localhost"
    self.smtp_port = 25
    self.smtp_user = ""
    self.smtp_password = ""
    if 'help' in opt:
      self.help()

    if 'to_email' in opt:
      self.to_email = opt['to_email']
    else:
      raise Exception("Please defined --to_email=...")

    if 'from_email' in opt:
      self.from_email = opt['from_email']
    else:
      raise Exception("Please defined --from_email=...")

    if 'bcc' in opt:
      self.bcc = opt['bcc']
    else:
      raise Exception("Please defined --bcc=...")

    if 'cc' in opt:
      self.cc = opt['cc']
    else:
      raise Exception("Please defined --cc=...")

    if 'debug' in opt:
      self.debug = 1

    if 'subject' in opt:
      self.subject = opt['subject']
    else:
      raise Exception("Please defined --subject=...")

    if 'smtp_password' in opt:
      self.smtp_password = opt['smtp_password']

    if 'smtp_port' in opt:
      self.smtp_port = opt['smtp_port']

    if 'smtp_server' in opt:
      self.smtp_server = opt['smtp_server']

    if 'smtp_user' in opt:
      self.smtp_user = opt['smtp_user']

    if 'body' in opt:
      self.body = opt['body']
    else:
      raise Exception("Please defined --body=...")

  def send(self):
    cset = 'utf8'
    msg = MIMEText(self.body, 'plain', cset)
    if self.bcc:
      msg['Bcc'] = self.bcc
    if self.cc:
      msg['Cc'] = self.cc
    msg['Subject'] = Header(self.subject, cset)
    msg['From'] = self.from_email
    msg['To'] = self.to_email

    try:
      server = smtplib.SMTP(self.smtp_server, self.smtp_port)
      if self.debug:
        server.set_debuglevel(1)
      if self.smtp_user and self.smtp_password:
        server.starttls()
        server.login(self.smtp_user, self.smtp_password)
      server.sendmail(self.from_email, [self.to_email], msg.as_string())
      server.quit()
      print("Sent email")
    except:
      print("Failed to send email / ")
      print(sys.exc_info()[0])
      sys.exit(1)

if __name__ == "__main__":
  argvs = sys.argv
  opt = {}
  for item in sys.argv[1:]:
    if re.search(r"=", item):
      [key, val] = item.split("=")
      key = re.sub(r"^\-\-?", "", key)
      if key:
        opt[key] = val
  mailer = Mailer(opt)
  mailer.send()
