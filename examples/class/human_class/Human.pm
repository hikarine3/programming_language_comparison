package Human;
use strict;
use Data::Dumper;
use warnings;

sub new(){
  my $class = shift;
  my $op = shift;
  my $name = $op->{'name'} || "";
  my $sex = $op->{'sex'} || "";
  my $self = {'name' => $name,
  'sex' => $sex};
  return bless($self);
}

sub sayName(){
  my $self = shift;
  if($self->{'name'}){
    print "My name is ".$self->{'name'}."\n";
  }
}

sub saySex(){
  my $self = shift;
  if($self->{'sex'}){
    print "My sex is ".$self->{'sex'}."\n";
  }
}

if ($0 eq __FILE__) {
  my $pro = new Human({'name' => 'FirstName LastName', 'sex' => 'male'});
  $pro->sayName();
  $pro->saySex();
}
else{
  1;
}