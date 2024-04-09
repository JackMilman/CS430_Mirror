use std::any::type_name_of_val;

fn main() {
    let mut population: u64 = 7_837_000_000;
    population += 1;
    println!("{}", population);
    for letter in "GROSS".split("") {
        println!("{}", letter);
    }
    let numbers = [51, -38, 95, -62];
    println!("{}", type_name_of_val(&numbers));
    println!("{}", sum(&numbers));
}

fn level(x: f64) ->f64 {
    x.sin().round()
}

enum Question {
    TrueFalse(bool),
    MultipleChoice(char),
}

fn is_correct(question: Question, answer: String) -> bool {
    match question {
        Question::TrueFalse(bit) => (bit && answer == "T") || (!bit && answer == "F"),
        Question::MultipleChoice(label) => label.to_string() == answer,
    }
}

fn sum(xs: &[i32]) -> i32 {
    let mut sum = 0;
    for x in xs {
        sum += x;
    }
    sum
}