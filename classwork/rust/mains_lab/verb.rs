use std::env;

fn main() {
    let word = env::args().nth(1).expect("Expected word");
    conjugate(&word);
}

fn conjugate(verb: &str) {
    let l = verb.len();
    let root = &verb[..l-2];
    let suffix = &verb[l-2..l];
    match suffix {
        "ar" => println!("{}{}\n{}{}\n{}{}\n{}{}\n{}{}", root, "o", root, "as", root, "a", root, "amos", root, "an"),
        "er" => println!("{}{}\n{}{}\n{}{}\n{}{}\n{}{}", root, "o", root, "es", root, "e", root, "emos", root, "en"),
        "ir" => println!("{}{}\n{}{}\n{}{}\n{}{}\n{}{}", root, "o", root, "es", root, "e", root, "imos", root, "en"),
        _ => println!("{}", "Unrecognized suffix"),
    };
}