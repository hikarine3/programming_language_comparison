package CapitalizeOnlyHeads;
use strict;
use warnings;

sub new(){
  my $class = shift;
  my $self = {};
  return bless($self);
}

sub convert(){
  my $self = shift;
  my $str = shift;
  $str=~ s{^(\s*)([a-z])|(\s)([a-z])}{
    my $space = $1;
    my $space2 = $3;
    my $char = $2;
    my $char2 = $4;
    if($char) {
      $space.uc($char);
    }
    else{
      $space2.uc($char2);
    }
  }gesx;
  return $str;
}

if ($0 eq __FILE__) {
  my $capitalizer = new CapitalizeOnlyHeads();
  my $str = " can you caplitalize?";
  print($capitalizer->convert($str)."\n");
}
else{
  1;
}