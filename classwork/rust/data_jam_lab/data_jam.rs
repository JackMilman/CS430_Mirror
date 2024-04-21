use std::fs;
use std::env;

#[derive(Debug, Clone)]
struct Country {
    country: String,
    capital: String,
    latitude: f64,
    longitude: f64,
    capital_population: i64,
    area: f64,
    country_population_1960: i64,
    country_population_2021: i64,
}

fn main() {
    let path = env::args().nth(1).expect("Expected file");
    let text = fs::read_to_string(path).unwrap();
    let data: Vec<Country> = text
                            .lines()
                            .skip(1)
                            .map(|country| parse_country(country))
                            .collect();

    // What country had the largest population growth from 1960 to 2021?
    let most_growth = data
                     .iter()
                     .max_by_key(|country| country.country_population_2021 - country.country_population_1960);
    println!("Country with the most growth:");
    println!("{:?}\n", most_growth.expect("Some country has maximum"));
    // India had the largest population growth.

    // How many countries had more than 50% population growth from 1960 to 2021?
    let more_than_50 = data
                 .iter()
                 .filter(|country| country.country_population_1960 as f64 *1.5 < country.country_population_2021 as f64);
    println!("Number of countries with more than 50% population growth from 1960 to 2021:");
    println!("{}\n", more_than_50.count());

    // Which country has the longest capital city name?
    let longest_name = data
                     .iter()
                     .max_by_key(|country| country.capital.len());
    println!("{:?}", longest_name.expect("Some country has the longest capital city name"));
}

fn parse_country(s: &str) -> Country {
    let mut s_split = s.split(",");
    let c: Country = Country {
        country: String::from(s_split.next().unwrap()),
        capital: String::from(s_split.next().unwrap()),
        latitude: s_split.next().expect("Expected latitude").parse::<f64>().unwrap(),
        longitude: s_split.next().expect("Expected longitude").parse::<f64>().unwrap(),
        capital_population: s_split.next().expect("Expected capital pop").parse::<i64>().unwrap(),
        area: s_split.next().expect("Expected area").parse::<f64>().unwrap(),
        country_population_1960: s_split.next().expect("Expected country pop 1960").parse::<i64>().unwrap(),
        country_population_2021: s_split.next().unwrap().parse::<i64>().unwrap(),
    };
    return c
}