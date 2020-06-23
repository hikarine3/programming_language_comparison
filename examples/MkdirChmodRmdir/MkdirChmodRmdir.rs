use std::fs;
use std::os::unix::fs::PermissionsExt;
use std::path::Path;

fn main() {
  let dir = "rust_dir";
  if !Path::new(dir).exists() {
    println!("mkdir");
    match fs::create_dir(dir) {
      Err(why) => println!("! {:?}", why.kind()),
      Ok(_) => {},
    }
  }

  if Path::new(dir).exists() {
    println!("chmod");
    match fs::set_permissions(dir, PermissionsExt::from_mode(0o777)) {
      Err(why) => println!("! {:?}", why.kind()),
      Ok(_) => {},
    }

    println!("rmdir");
    match fs::remove_dir(dir) {
      Err(why) => println!("! {:?}", why.kind()),
      Ok(_) => {},
    }
  }
}