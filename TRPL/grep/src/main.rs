// a simple IO project like grep
// to search a given string in the file
extern crate grep;

use std::env;
use std::process;
use grep::Config;
use grep::run;

fn main() {
    // note that the first arg is always the name of runfile
    let args: Vec<String> = env::args().collect();

    let config = Config::new(&args).unwrap_or_else(|err|{
        process::exit(1);
    });

    if let Err(e) = run(config) {
        process::exit(1);
    };
       
}
