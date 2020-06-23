extern crate inflections;
use inflections::Inflect;
fn main() {
  let str = " can you caplitalize?";
  println!("{}", str.to_title_case());
}
