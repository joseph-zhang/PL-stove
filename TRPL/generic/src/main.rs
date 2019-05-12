// this file will show the basic usage of generic in Rust
// a function to find the biggest item in a list is implemented

// notice the trait bound
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
    let mut largest = list[0];

    for &item in list.iter() {
        if item > largest {
            largest = item;
        }
    }

    largest
}

/*
Note that the previous function will execute copy action. Actually,
'list.iter()' gives you an iterator over references to elements of list.
In 'for &item in ...', '&item' is where the pattern matching occur, hence
if you use 'item', you dereference it and use it as a T, not &T.

To modify the largest function without any Clone or Copy:

fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];

    for item in list.iter() {
        if item > largest {
            largest = item;
        }
    }

    largest
}
*/

fn main(){
    let number_list = vec![33, 55, 25 ,70];
    let num_res = largest(&number_list);
    println!("The largest number in number_list is {}", num_res);

    let char_list=  vec!['a', 'c', 'b', 'd'];
    let char_res = largest(&char_list);
    println!("The largest char in char_list is {}", char_res);

}
