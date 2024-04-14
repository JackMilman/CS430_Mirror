use std::vec::Vec;
use std::fs;

// fn main() {
//     let mut balance: i64 = 9_999_999_999;
//     balance *= -1;
//     println!("{}", balance);
//     let xs = [4; 5];
//     for x in xs {
//         print!("{}", x);
//     }
//     println!();
//     let durations = Vec<f32>::new();
//     let path = "blablabla";
//     match fs::read_to_string(path) {
//         Err(_) => panic!("Read failed."),
//         Ok(text) => println!("{}\n{}", path, text),
//       };
// }

fn f(data: (String, usize)) {
    // ...
  }
  
  fn main() {
    let tag = "img";
    f((tag.to_uppercase(), tag.len()));
  }

enum Host {
    WithPort(String, i64),
    WithoutPort(String),
}

fn https_url(host: Host) -> String {
    match host {
        Host::WithoutPort(domain) => format!("https://{}:80", domain),
        Host::WithPort(domain, port) => format!("https://{}:{}", domain, port),
    }
}

fn g(c: char) -> bool {
    c.is_alphabetic() || c == '_'
}