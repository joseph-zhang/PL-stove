extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
	loop{
    	println!("Guess the number!");
		
		let secret_number = rand::thread_rng().gen_range(1, 101);	
	 	
		println!("Please input your guess.");

    	let mut guess = String::new();

    	io::stdin().read_line(&mut guess)
        	.expect("Failed to read line");

		let guess: u32 = match guess.trim().parse(){
			Ok(num) => num,
			Err(_)  => continue,
		};

    	println!("You guessed: {}", guess);

		match guess.cmp(&secret_number){
			Ordering::Less    => println!("samller than {}", secret_number),
			Ordering::Greater => println!("bigger than {}", secret_number),
			Ordering::Equal   => {	
				println!("You win!!");
				break;
			}	
		}
	}
}
