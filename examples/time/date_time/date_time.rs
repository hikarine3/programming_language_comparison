extern crate chrono;
use chrono::{Local, DateTime};

fn main() {
  let now: DateTime<Local> = Local::now();
  println!("{}", now.format("%Y/%m/%d %H:%M:%S"))
}