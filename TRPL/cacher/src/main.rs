// this file show the mechanism of cacher
// also as an example of closure
use std::thread;
use std::time::Duration;
use std::collections::HashMap;
use std::collections::hash_map::Entry;

// 'Fn' trait is implemented in all closures
struct Cacher<T>
where T: Fn(u32) -> u32 {
    calculation: T,
    val: HashMap<u32, u32>,
}

// add methods and associate functions for Cacher
impl<T> Cacher<T>
where T: Fn(u32) -> u32 {
    fn new(calculation: T) -> Cacher<T> {
        Cacher {
            calculation,
            val: HashMap::new(),
        }
    }
    
    fn value(&mut self, arg: u32) -> u32 {
        match (self.val).entry(arg) {
            Entry::Occupied(entry) => entry.into_mut().clone(),
            Entry::Vacant(entry) => {
                let newval = (self.calculation)(arg);
                entry.insert(newval);
                newval
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
