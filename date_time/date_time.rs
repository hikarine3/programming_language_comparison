extern crate chrono;
use chrono::{Local, DateTime, TimeZone};

fn main() {
  let now: DateTime<Local> = Local::now();
  prontln!("{}", now.format("%Y/%m/%d %H:%M:%S"))
}