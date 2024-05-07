#![allow(dead_code)]
use std::env;
use std::slice;
fn sumhow(a: i32, b: i32, c: i32) -> bool {
    ((a + b) == c) || ((a + c) == b) || ((b + c) == a)
}

enum Operation {
    Add,
    Subtract,
    Multiply,
    Divide,
}

fn evaluate(first: f32, second: f32, op: Operation) -> f32 {
    match op {
        Operation::Add => first + second,
        Operation::Subtract => first - second,
        Operation::Multiply => first * second,
        Operation::Divide => first / second,
    }
}

fn teams(names: Vec<&str>) -> Vec<String> {
    names
         .iter()
         .filter(|name| name.len() < 15)
         .map(|name| name.to_uppercase())
         .collect()
}

fn show_friendlies(pairs: Vec<(String, f64)>) {
    let sum = pairs.iter().fold(0.0, |acc, (_, xfactor)| acc + xfactor);
    let num = pairs.iter().count() as f64;
    let avg = sum / (if num > 0.0 {num} else {1.0});
    pairs
         .iter()
         .filter(|(_, xfactor)| xfactor > &avg)
         .for_each(|(name, _)| println!("{}", name));
}

struct Rgb {
    r: u8,
    g: u8,
    b: u8,
}
  
impl Rgb {
    fn white() -> Self {
        Rgb {
            r: 255,
            g: 255,
            b: 255,
        }
    }

    fn black() -> Self {
        Rgb {
            r: 0,
            g: 0,
            b: 0,
        }
    }
}

fn halfway(first: i32, second: i32) -> Option<i32> {
    let mid = (first as f32 + second as f32) / 2.0;
    if mid == (mid as i32) as f32 {
        Some(mid as i32)
    } else {
        None
    }
}

// fn main() {
//     println!("{}", sumhow(3, 4, 7));
//     println!("{}", evaluate(3.1, 4.1, Operation::Add));

//     let pres = vec![
//     "SCREAMING_SNAKES",
//     "The Brute Force",
//     "tooStrong"
//     ];
//     let posts = teams(pres);

//     // prints ["TOOSTRONG"]
//     println!("{:?}", posts);

//     let people = vec![
//     ("Alice".to_string(), 4.5),
//     ("Bob".to_string(), 4.5),
//     ("Carol".to_string(), 1.0),
//     ];

//     show_friendlies(people);
//     // prints:
//     // Alice
//     // Bob
// }


// fn main() {
//     let strng = env::args().nth(1).expect("Expected string");
//     let num = env::args().nth(2).unwrap().parse::<i32>().expect("Expected integer");
//     for _ in 0..num {
//         println!("{}", strng);
//     }
// }

fn main() {
    let nums: Vec<u32> = env::args().skip(1).map(|val| val.parse::<u32>().unwrap()).collect();
    let mut sum = 0;
    for pair in nums.chunks(2) {
        sum += pair[1] - pair[0] + 1;
    }
    println!("{:?}", sum);
}