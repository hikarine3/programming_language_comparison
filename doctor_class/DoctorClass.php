<?php
namespace FirstClass\Example;
require './human_class/HumanClass.php';
use \FirstClass\Example;

class Doctor extends Human{
  private $specialty;

  public function __construct($name, $sex, $specialty){
    parent::__construct($name, $sex);
    $this->specialty = $name;
  }

  public function saySpecialty(){
    print "My specialty is ".$this->specialty."\n";
  }
}

if (!isset(debug_backtrace()[0])) {
  $doctor1 = new Doctor('FirstName LastName', 'Male', 'Cardiology');
  $doctor1->sayName();
  $doctor1->saySex();
  $doctor1->saySpecialty();
}

