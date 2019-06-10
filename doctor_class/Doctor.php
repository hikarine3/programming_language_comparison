<?php
namespace FirstClass\Example2;
require '../human_class/Human.php';
use FirstClass\Example1\Human;

class Doctor extends Human{
  private $specialty;

  public function __construct($opt){
    parent::__construct($opt);
    $this->specialty = $opt["specialty"];
  }

  public function saySpecialty(){
    print "My specialty is ".$this->specialty."\n";
  }
}

if (!isset(debug_backtrace()[0])) {
  $doctor1 = new Doctor(["name"=>"FirstName LastName", "sex"=>"male", "specialty"=>"cardiology"]);
  $doctor1->sayName();
  $doctor1->saySex();
  $doctor1->saySpecialty();
}
