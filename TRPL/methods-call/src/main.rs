// This file contains some methods about 'methods-call'
// first, a structure is defined as an example

struct Circle{
    x: f64,
    y: f64,
    radius: f64,
}

// add two methods for this structure,
// it is possible to use them as chain, just like c.grow(xx).area()
impl Circle{
    fn area(&self) -> f64{
        std::f64::consts::PI * (self.radius * self.radius)
    }

    fn grow(&self, increment: f64) -> Circle{
        Circle{x: self.x, y: self.y, radius: self.radius + increment}
    }
}

// a builder method can be used to create Circle obj
struct CircleBuilder{
    x: f64,
    y: f64,
    radius: f64,
}

impl CircleBuilder{
    // define default construct Associated function 
    fn new() -> CircleBuilder {
        CircleBuilder{x: 0.0, y: 0.0, radius: 1.0}
    }

    fn x(&mut self, coord: f64) -> &mut CircleBuilder{
        self.x = coord;
        self
    }

    fn y(&mut self, coord: f64) -> &mut CircleBuilder{
        self.y = coord;
        self
    }

    fn radius(&mut self, radius: f64) -> &mut CircleBuilder{
        self.radius = radius;
        self
    }

    fn finalize(&self) -> Circle{
        Circle{x: self.x, y: self.y, radius: self.radius}
    }
}

fn main(){
    // a kind of usage is chian
    let c = Circle{x: 0.0, y: 0.0, radius: 2.0};
    println!("area of circle after grow: {}", c.grow(2.0).area());

    // use builder pattern to create a Circle obj
    println!("Now create a new circle obj by using builder pattern..");
    let c2 = CircleBuilder::new()
        .x(1.0)
        .y(1.0)
        .radius(2.0)
        .finalize();
    
    println!("area: {}", c2.area());
    println!("x: {}", c2.x);
    println!("y: {}", c2.y);  
}
