extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main(){
    loop{
        println!("Guess the number!");
        let secret_number = rand::thread_rng().gen_range(1, 101);
        println!("Please input your guesss.");
        let mut guess = String::new();

        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = match guess.trim().parse(){
            Ok(num) => num,
            Err(_)  => continue,
        };

        println!("you guessed: {}", guess);
        match guess.cmp(&secret_number){
            Ordering::Less     => println!("smaller than {}", secret_number),
            Ordering::Greater => println!("bigger than {}", secret_number),
            Ordering::Equal   => {
                println!("You win!!");
                break;
            }
        }
    }
}
