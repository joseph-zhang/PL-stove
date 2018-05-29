// this file show the mechanism of cacher
// also as an example of closure
use std::thread;
use std::time::Duration;


// 'Fn' trait is implemented in all closures
struct Cacher<T>
where T: Fn(u32) -> u32 {
    calculation: T,
    val: Option<u32>,
}

// add methods and associate functions for Cacher
impl<T> Cacher<T>
where T: Fn(u32) -> u32 {
    fn new(calculation: T) -> Cacher<T> {
        Cacher {
            calculation,
            val: None,
        }
    }
    
    fn value(&mut self, arg: u32) -> u32 {
        match self.val {
            Some(v) => v,
            None => {
                let v = (self.calculation)(arg);
                self.val = Some(v);
                v
            },   
        }
    }   
}

fn generate_workout(intensity: u32, random_number: u32) {
    let mut expensive_result = Cacher::new(|num| {
        println!("calculating slowly...");
        thread::sleep(Duration::from_secs(2));
        num
    });

    if intensity < 25 {
        println!(
            "Today, do {} pushups!",
            expensive_result.value(intensity)
        );
        println!(
            "Next, do {} situps!",
            expensive_result.value(intensity)
        );
    } else {
        if random_number == 3 {
            println!("Take a break today! Remember to stay hydrated!");
        } else {
            println!(
                "Today, run for {} minutes!",
                expensive_result.value(intensity)
            );
        }
    }
}

fn main() {
    let simulated_user_specified_value = 12;
    let simulated_random_number = 7;

    generate_workout(
        simulated_user_specified_value,
        simulated_random_number
    );
}
