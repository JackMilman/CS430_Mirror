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
                return if target < *value {
                    left.contains(target)
                } else if target > *value {
                    right.contains(target)
                } else {
                    true
                };
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
          }
        }
      }
}

fn main() {
    let mut tree = Tree::<u32>::Empty;
    tree.add(3);
    tree.add(4);
    tree.add(5);
    println!("tree.contains(3): {:?}", tree.contains(3));
    println!("tree.contains(4): {:?}", tree.contains(4));
    println!("tree.contains(5): {:?}", tree.contains(5));
    println!("tree.contains(6): {:?}", tree.contains(6));
}