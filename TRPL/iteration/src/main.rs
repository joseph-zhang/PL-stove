// iteration can be used with FP in Rust
// Though it is a little different from some other languages
// All the iterators have implemented the Iteration trait
// iterator is lazy in Rust, hence it only work after the consuming adaptors is used

fn iter_sum() {
    let v1 = vec![1, 2, 3];

    // v1_iter is only a reference, not as ownership of source
    let v1_iter = v1.iter();

    // sum() consume the iterator
    let total: i32 = v1_iter.sum();

    assert_eq!(total, 6);
}

fn iter_map() {
    let v1 = vec![1, 2, 3];

    // collect() consume the iterator
    let v2: Vec<_> = v1.iter().map(|x| x + 1).collect();

    assert_eq!(v2, vec![2, 3, 4]);
}

#[derive(PartialEq, Debug)]
struct Shoe {
    size: u32,
    style: String,
}

fn shoes_in_my_size(shoes: Vec<Shoe>, my_size: u32) -> Vec<Shoe> {
    // into_iter() will get the ownership
    shoes.into_iter()
        .filter(|shoe| shoe.size == my_size)
        .collect()
}

fn filters_by_size() {
    let shoes = vec![
        Shoe { size: 10, style: String::from("sneaker") },
        Shoe { size: 13, style: String::from("sandal") },
        Shoe { size: 10, style: String::from("boot") },
    ];

    let in_my_size = shoes_in_my_size(shoes, 10);

    assert_eq!(
        in_my_size,
        vec![
            Shoe { size: 10, style: String::from("sneaker") },
            Shoe { size: 10, style: String::from("boot") },
        ]
    );
}

fn main() {
    iter_sum();
    iter_map();
    filters_by_size();
}
