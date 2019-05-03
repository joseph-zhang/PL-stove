// The file to introduce some basic ways to use vector collection

fn main() {
    // create a new vector by using associated functions
    let mut v: Vec<i32> = Vec::new();

    {
        // a more realistic way to create a vector is using vec! macro
        let _v_p = vec![1, 2, 3];
    } // here the v_p is dropped

    // push a new element back
    // here, a mutable reference occur
    v.push(3);
    v.push(4);

    // here, immutable reference occur
    let first = &v[0];
    println!("The first element is: {}", first);


    // iterating over the values in a vector
    for i in &v {
        println!("{}", i);
    }

    // another method to read element
    match v.get(0) {
        Some(first) => println!("The third element is {}", first),
        None => println!("There is no third element."),
    }
}
