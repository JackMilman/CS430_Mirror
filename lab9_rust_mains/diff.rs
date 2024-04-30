use std::env;
use std::iter::zip;

fn main() {
    let path1 = env::args().nth(1).expect("Expected first file");
    let path2 = env::args().nth(2).expect("Expected second file");
    let text1 = std::fs::read_to_string(path1).unwrap();
    let text2 = std::fs::read_to_string(path2).unwrap();
    let walker = zip(text1.chars(), text2.chars());
    let mut diffs = "".to_string();
    for letters in walker {
        if letters.0 == letters.1 {
            diffs.push(' ');
        } else {
            diffs.push('^');
        }
    }
    println!("{}\n{}\n{}", text1, text2, diffs);
}
