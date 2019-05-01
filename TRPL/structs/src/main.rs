#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn can_hold(&self, another: &Rectangle) -> bool {
        self.width > another.width && self.height > another.height
    }

    fn square(size: u32) -> Rectangle {
        Rectangle {width: size, height: size}
    }
}

fn main() {
    let rect1 = Rectangle {width: 30, height: 50};

    let rect2 = Rectangle::square(20);

    println!("The area of the rect1 is {} square pixels.",
             rect1.area());
    println!("The area of the rect2 is {} square pixels.",
              rect2.area());
    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
}
