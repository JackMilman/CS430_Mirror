#![allow(dead_code)]

use std::env;
use std::fs;
use std::io;


fn main() {
    // let path = env::args().nth(1).expect("Usage: wc path/to/file");
    for path in env::args().skip(1) {
        let stats = count(&path);
        println!("{:?}", stats);
    }
}

fn count (path: &str) -> Result<Statistics, io::Error> {
    // match fs::read_to_string(path) {
    //     Ok(text) => Ok(Statistics {
    //         character_count : text.len(),
    //         word_count : text.split_whitespace().count(),
    //         line_count : text.lines().count(),
    //     }),
    //     Err(e) => Err(e),
    // }

    let text = fs::read_to_string(path)?;
    Ok(text) => Ok(Statistics {
        character_count : text.len(),
        word_count : text.split_whitespace().count(),
        line_count : text.lines().count(),
    }),
    
}

#[derive(Debug)]
struct Statistics {
    character_count: usize,
    word_count: usize,
    line_count: usize,
}