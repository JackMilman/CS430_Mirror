use std::env;
use std::ops::RangeInclusive;

fn main() {
    let arg = "apple|bannana|canteloupe|durian|apple";
    // let arg = env::args().nth(1).expect("Expected strings");
    let x = middle_word(&arg);
    println!("{}", x);
    let vecs: Vec<RangeInclusive<i32>> = vec![8..=10, 0..=0];
    println!("{}", total(&vecs));
}

fn middle_word(q: &str) -> String {
    let s: Vec<&str> = q.split('|').collect();
    let length = s.len();
    let idx = length / 2;
    String::from(s[idx])
}

fn total (ranges: &Vec<RangeInclusive<i32>>) -> usize {
    ranges.iter()
        .map(|r| r.clone().count())
        .sum()
}