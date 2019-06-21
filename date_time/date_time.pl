print(getCurrentDateTime()."\n");

sub getCurrentDateTime(){
  my ($sec,$min,$hour,$mday,$mon,$year,$wday)=localtime();
  $mon++;
  $year+=1900;
  if($mon < 10){
    $mon = '0'.$mon;
  }
  if($mday < 10){
    $mday = '0'.$mday;
  }
  if($hour < 10){
    $hour = '0'.$hour;
  }
  if($min < 10){
    $min = '0'.$min;
  }
  if($sec < 10){
    $sec = '0'.$sec;
  }
  return join("/", $year, $mon, $mday)." ".join(":", $hour, $min, $sec);
}
