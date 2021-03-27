<?php
namespace FirstClass\ProgrammingLang;

class NormalizeJapanese {
  public function __construct($opt = []){
  }
 
  public function normalize($str){
    return mb_convert_kana($str, "KVa");
  }
}
 
if ( !isset(debug_backtrace()[0]) ) {
  $str = "ﾊﾝｶｸ１２ａΒ＠";
  $nj = new NormalizeJapanese();
  print($nj->normalize($str));
}