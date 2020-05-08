package MkdirChmodRmdir;
use strict;

sub new(){
  my $class = shift;
  my $self = {
    'dir' => 'perl_dir'
  };
  return bless($self);
}

sub run(){
  my $self = shift;
  if(!-d $self->{'dir'}) {
    print "mkdir\n";
    mkdir($self->{'dir'});
  }

  if(-d $self->{'dir'}) {
    print "chmod\n";
    chmod(0777, $self->{'dir'});

    print "rmdir\n";
    rmdir($self->{'dir'});
  }
}

if ($0 eq __FILE__) {
  my $mcr = new MkdirChmodRmdir();
  $mcr->run();
}
else{
  1;
}