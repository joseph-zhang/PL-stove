// this file provide some basic usage of HashMap<K, V> in Rust.
// use new to construct empty HashMap variable.
// use insert() method to add element in HashMap (ownership will move),
//     Note that HashMap is Homogeneous, that is, either key or value must be same type.
// use get() method to acquire element in HashMap.
// use entry() and or_insert() methods to insert element whose key is not in HashMap,
//     if the insert() method is used in this circumstance, the value under the given key will be overwrited.
use std::collections::HashMap;

    
fn main() {
    // construct an empty HashMap
    let mut scores = HashMap::new();
    println!("create a new HashMap..");
    
    // use insert() method to add element
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);

    /* some other method to construct HashMap */
    let teams  = vec![String::from("Blue"), String::from("Yellow")];
    let initial_scores = vec![10, 50];
    // use iteration and zip function to construct HashMap 
    let temp_scores: HashMap<_, _> = teams.iter().zip(initial_scores.iter()).collect();

    // acquire an element
    let team_name = String::from("Blue");
    {
        let score = match scores.get(&team_name){
            Some(score) => score,
            None => panic!("cannot find key: {}", team_name),
        };
        println!("get score with {}: {}", team_name, score);
    }

    // try to insert Blue if it is not exist
    scores.entry(String::from("Blue")).or_insert(50);
    {
        let score = match scores.get(&team_name){
            Some(score) => score,
            None => panic!("cannot find key: {}", team_name),
        };
        println!("After or_insert, get score with {}: {}", team_name, score);
    }
    
}
    
