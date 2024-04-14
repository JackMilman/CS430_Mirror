// use std::env;

fn main() {
    // let arg = env::args().nth(1).expect("Expected number argument");
    // let num: u32 = arg.parse().unwrap();
    for n in 1..130 {
        println!("{}", ordinal(n))
    }    
}

fn ordinal(num: u32) -> String {
    let last_two = num % 100;
    let suffix = 
        if 10 < last_two && last_two < 21 {
            "th"
        } else {
            match num % 10 {
                1 => "st",
                2 => "nd",
                3 => "rd",
                _ => "th"
            }
        };
    let result = format!("{}{}", num, suffix);
    return result
}