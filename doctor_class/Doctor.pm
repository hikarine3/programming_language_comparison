package Doctor;
use strict;
use Data::Dumper;
use warnings;
use File::Basename;
use lib dirname(__FILE__).'/../human_class';
use base qw(Human);

sub new(){
  my $class = shift;
  my $op = shift;
  my $self = Human->new( $op );
  $self = bless $self, $class;
  $self->{'specialty'} = $op->{'specialty'};
  return $self;
}

sub saySpecialty(){
  my $self = shift;
  if($self->{'specialty'}){
    print "My specialty is ".$self->{'specialty'}."\n";
  }
}

if ($0 eq __FILE__) {
  my $doctor1 = new Doctor({'name' => "FirstName LastName", "sex" => "male", "specialty" => "cardiology"});
  $doctor1->sayName();
  $doctor1->saySex();
  $doctor1->saySpecialty();
}
else{
  1;
}