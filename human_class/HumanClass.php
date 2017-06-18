<?php
class Human{
  private $name;
  private $sex;
  public function __construct($name, $sex){
    $this->name = $name;
    $this->sex = $sex;
  }

  public function sayName(){
    print "My name is ".$this->name."\n";
  }

  public function saySex(){
    print "My sex is ".$this->sex."\n";
  }
}

$pro = new Human('FirstName LastName', 'Male');
$pro->sayName();
$pro->saySex();

