<?php
namespace FirstClass;

class Mailer {
  private $to_email = "";
  private $from_email = "";
  private $subject = "";
  private $bcc = "";
  private $cc = "";
  private $body = "";
  private $smtp_server = "";
  private $smtp_port = "";
  private $smtp_user = "";
  private $smtp_password = "";  

  public function constructor($opt) {
    if (isset($opt['to_email'])) {
      $this->to_email = $opt['to_email'];
    }
    else{
      die("Please defined --to_email=...");
    }

    if (isset($opt['from_email'])) {
      $this->from_email = $opt['from_email'];
    }
    else{
      die("Please defined --from_email=...");
    }

    if (isset($opt['bcc'])) {
      $this->bcc = $opt['bcc'];
    }

    if (isset($opt['cc'])) {
      $this->cc = $opt['cc'];
    }

    if (isset($opt['subject'])) {
      $this->subject= $opt['subject'];
    }
    else{
      die("Please defined --subject=...");
    }

    if (isset($opt['body'])) {
      $this->subject= $opt['body'];
    }
    else{
      die("Please defined --body=...");
    } 
  }

  public function sendEmail() {
    $headers = "From: ". $this->from_email. "\r\n";
    if($this->bcc) {
      $headers .= "BCC: ".$this->bcc. "\r\n";
    }
    if($this->cc) {
      $headers .= "CC: ".$this->cc. "\r\n";
    }
    

    if (mail($this->to_email, $this->subject, $this->body, $headers)) {
      print "Sent email\n";
    } else {
      die("Failed to send email");
    }
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $opt = [];
  for ($i=1; $i<count($argv); $i++) {
    if( preg_match('/=/', $argv[$i]) ) {
      list($key, $val) = explode("=", $argv[$i]);
      $key = preg_replace('/^--?/', '', $key);
      if($key) {
        $opt[$key] = $val;
      }
    }
  }
  $pro = new Mailer($opt);
  $pro->sendEmail($opt);
}
