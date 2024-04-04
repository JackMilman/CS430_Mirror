use std::thread;
use std::time::Duration;
use std::io::{self,Write};

fn main() {
    let mut time: i32 = 60;
    while time >= 0 {
        print!("\r{}", time);
        io::stdout().flush().unwrap();
        thread::sleep(Duration::from_millis(1000));
        time -= 1;
    }
}