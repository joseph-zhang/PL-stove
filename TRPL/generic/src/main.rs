// this file will show the basic usage of generic in Rust
// a function to find the biggest item in a list is implemented

// notice the trait bound 
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T{
    let mut largest = list[0];

    for &item in list.iter(){
        if item > largest{
            largest = item;
        }
    }
    
    largest
}

fn main(){
    let number_list = vec![33, 55, 25 ,70];
    let num_res = largest(&number_list);
    println!("The largest number in number_list is {}", num_res);

    let char_list=  vec!['a', 'c', 'b', 'd'];
    let char_res = largest(&char_list);
    println!("The largest char in char_list is {}", char_res);

}
