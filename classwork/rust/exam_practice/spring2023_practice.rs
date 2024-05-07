#![allow(dead_code)]
use std::env;

fn word_count(sl: &str) -> usize {
    sl.split(" ")
      .filter(|s| !s.is_empty())
      .collect::<Vec<&str>>()
      .len()
}

// fn longest_word(sl: &str) {
//     let v = sl.split(" ")
//       .filter(|s| !s.is_empty())
//       .fold(0, |a: usize, b| a.max(b.len()));
//     //   .collect();
//     println!("hi {:?}", v);
// }

#[derive(Debug)]
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

impl Coin {
    fn worth(&self) -> u32 {
        match self {
            Coin::Penny => 1,
            Coin::Nickel => 5,
            Coin::Dime => 10,
            Coin::Quarter => 25,
        }
    }
}

fn tally(coins: &Vec<Coin>) -> u32 {
    coins.iter().fold(0, |acc, coin| acc + coin.worth())
}

fn divmod(numerator: u32, denominator: u32) -> (u32, u32) {
    (numerator / denominator, numerator % denominator)
}

fn curve(pairs: &Vec<(String, u32)>) {
    let max = pairs.iter().fold(0, |acc: u32, (_, score)| acc.max(*score));
    let bump = 100 - max;
    pairs.iter().for_each(|(name, score)| println!("{}: {}", name, score + bump));
}

struct CellAddress {
    column: u8,
    row: u8,
}

impl CellAddress {
    fn new(c: u8, r: u8) -> Self {
        CellAddress {
            column: c,
            row: r,
        }
    }

    fn label(&self) -> String {
        format!("{}{}", (self.column + 65) as char, self.row)
    }
}

fn halfters(vals: &Vec<i32>) -> Vec<f64> {
    vals.iter().map(|val| *val as f64 + 0.5).collect()
}

// fn main() {
//     println!("{}", word_count("   I forget   everything that I don't need to turn into a story.  "));
//     // println!("{:?}", longest_word("   I forget   everything that I don't need to turn into a story.  "));
//     println!("{:?}", divmod(12, 5));
//     println!("{:?}", Coin::Quarter.worth());
//     let vals = vec![("marisol".to_string(), 91), ("absd".to_string(), 80), ("efqe".to_string(), 36)];
//     curve(&vals);
//     println!("{:?}", CellAddress::new(1, 3).label());
//     println!("{:?}", halfters(&vec![7, 10, -99]));
// }

fn main() {
    let mut range: Vec<i32> = env::args().skip(1).map(|val| val.parse::<i32>().unwrap()).collect();
    range.sort();
    let max = range[range.len() - 1];
    let min = range[0];
    for num in (min + 1)..max {
        if !range.contains(&num) {
            println!("{}", num);
        } else {
            // Nothing
        }
    }
}