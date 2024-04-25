trait Cubed<T> {
    fn cubed(&self) -> T;
}
  
impl Cubed<u32> for u32 {
    fn cubed(&self) -> u32 {
        self * self * self
    }
}
  
impl Cubed<f64> for f64 {
    fn cubed(&self) -> f64 {
        self * self * self
    }
}


#[derive(PartialEq, Debug)]
enum Rotation {
  Clockwise,
  Counterclockwise,
}

impl Not for Rotation {
  type Output = Self;
  fn not(self) -> Self::Output {
    match self {
    Rotation::Clockwise => Rotation::Counterclockwise,
    Rotation::Counterclockwise => Rotation::Clockwise,
    }
  }
}