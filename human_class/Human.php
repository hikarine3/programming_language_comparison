<?php
namespace FirstClass\Example1;

class Human{
  private $name;
  private $sex;
  public function __construct($opt){
    $this->name = $opt["name"];
    $this->sex = $opt["sex"];
  }

  public function sayName(){
    print "My name is ".$this->name."\n";
  }

  public function saySex(){
    print "My sex is ".$this->sex."\n";
  }
}

if ( !isset(debug_backtrace()[0]) ) {
  $pro = new Human(["name" => "FirstName LastName", "sex" => "male"]);
  $pro->sayName();
  $pro->saySex();
}
