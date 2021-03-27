extern crate chrono;
use chrono::{Duration, Local, DateTime};

fn main() {
  let date: DateTime<Local> = Local::now() + Duration::days(-2);
  println!("{}", date.format("%Y/%m/%d"))
}