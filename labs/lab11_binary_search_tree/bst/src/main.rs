#![allow(dead_code)]
use std::fmt::Display;
use std::ops::RangeInclusive;

enum Tree<T> {
    Empty,
    Node {
        value: T,
        left: Box<Tree<T>>,
        right: Box<Tree<T>>
    },
}

impl<T: PartialOrd> Tree<T> {
    fn contains(&self, target: T) -> bool {
        match self {
            Tree::Empty => false,
            Tree::Node { value, left, right } => {
                if target < *value {
                    left.contains(target)
                } else if target > *value {
                    right.contains(target)
                } else {
                    true
                }
            },
        }
    }

    fn add(&mut self, new_value: T) {
        match self {
            Tree::Empty => {
                *self = Tree::Node {
                    value: new_value,
                    left: Box::new(Tree::Empty),
                    right: Box::new(Tree::Empty),
                };
            },
            Tree::Node { value, left, right } => {
                if new_value < *value {
                    left.add(new_value);
                } else if new_value > *value {
                    right.add(new_value);
                }
            },
        }
    }
}

impl<T> Tree<T> {
    fn len(&self) -> usize {
        match self {
            Tree::Empty => {
                0
            },
            Tree::Node {value: _, left, right } => {
                1 + left.len() + right.len()
            }
        }
    }
}

impl<T: Display> Tree<T> {
    fn print(&self) {
        match self {
            Tree::Empty => {
                // Do nothing
            },
            Tree::Node {value, left, right} => {
                left.print();
                println!("{}", value);
                right.print();
            }
        }
    }
}

impl<T: PartialOrd + Copy> Tree<T> {
    fn between(&self, range: &RangeInclusive<T>, v: &mut Vec::<T> ) {
        match self {
            Tree::Empty => {
                // Do nothing
            },
            Tree::Node {value, left, right} => {
                if value > range.start() {
                    left.between(range, v);
                }
                if value >= range.start() && value <= range.end() {
                    v.push(*value);
                }
                if value < range.end() {
                    right.between(range, v);
                }
            }
        }
    }
}

fn main() {
    let mut tree = Tree::<i32>::Empty;
    tree.add(7);
    tree.add(3);
    tree.add(9);
    tree.add(13);
    println!("{}", tree.len());
    tree.print();
    let mut v: Vec<i32> = vec![];
    let range: RangeInclusive<i32> = RangeInclusive::new(8, 13);
    println!("{:?}", v);
    tree.between(&range, &mut v);
    println!("{:?}", v);
}
