// This file will show the basic usage of Box point.
// Box point is helpfull when you want to use a block of data but don't know its size exactly.
// If you use Box to store data, these data will be save on heap instead of stack.

// An example is to define Recursive data structures
// In haskell, if you are going to define list recursively, you may write it as
// data Lst t = Nil | Cons t (Lst t)
// this can be defined by using box ptr in Rust


// use enum to define algebraic data strucutre in Rust
enum Lst<T> {
    Nil,
    Cons(T, Box<Lst<T>>),
}

use Lst::{Nil, Cons};
    
fn len<T>(l: &Lst<T>) -> u32 {
    match *l {
        Nil => 0,
        Cons(_, ref x) => 1 + len(&*x)
    }
}

fn main() {
    let l = Cons(1,
                 Box::new(
                     Cons(3,
                           Box::new(Nil))));
    println!("{}", len(&l));
}
