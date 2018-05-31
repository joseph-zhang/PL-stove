// this file shows notions about string type in Rust.
// In core language, rust has only one string type -->  string slice 'str',
// which are references to some UTF-8 encoded string data stored elsewhere.

// The 'String' type, which is provided by Rust’s standard library rather than coded into the core language,
// is a growable, mutable, owned, UTF-8 encoded string type. 


fn main() {
    // create an empty String data
    let mut s = String::new();

    // use to_string() method to transfer a type which implement Display trait to
    // a correspond String data. For example, a literal.
    s = "initial contents".to_string();

    // this can be also done by using String::from function
    s = String::from("initial contens");

    // String is growable, we can use push _str() method to append sth
    s.push_str("--aa");
    // or you can use push() method to append a character
    s.push('c');

    // '+' is redefined for String, fn add(self, s: &str) -> String
    let s1 = String::from("Hello, ");
    let s2 = String::from("world!");
    let s3 = s1 + &s2; // Note that s1 has been moved here and can no longer be used

    // you should know that, the rust String cannot be indexed
    // code like 'let h = s1[0]' leads to an error
    // a method to traverse a string is using chars() method:
    for c in s2.chars() {
        println!("{}", c);
    }

    // or use bytes() to get original bytes
    for b in s2.bytes() {
        println!("{}", b);
    }    
}
