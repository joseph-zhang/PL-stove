// this foler named lifetime
// the target is showing this useful idea in rust language
// in rust variable binding, they 'have ownership' of what they’re bound to
// to return the ownership, the reference is used.

fn test1(){
    // this will lead to error
    // Note that in a scope, some rules are given:
    //    - one or more reference(&T) to a resource
    //    - exactly one mutable refernece (&mut T)
    // inference and mutable one cannot appear in the same time.
    let mut x = 5;
    let y = &mut x;

    *y += 1;

    // error occur: immutable borrow(&x) occurs here 
    // and this kind of error can be found in compile time.
    println!("{}",x);  
}

fn test1_fixed(){
    // to fix this problem, just throw that part of code
    // in another code block.
    let mut x = 5;{
        let y = &mut x;
        *y += 1;
    }

    println!("{}", x);
}

fn test2(){
    let take = |_v: Vec<i32>| {println!("blah, blah..")};
    let v = vec![1,2,3];
    take(v);
    
    // error occur: value used here after move
    println!("{}",v[1]);
}

fn test2_fixed(){
    let take = |v: &Vec<i32>| {println!("blah, blah..")};
    let v = vec![1,2,3];
    take(&v);
    println!("{}",v[1]);
}

fn skip_prefix(line: &str, prefix: &str) -> &str {line}
//fn skip_prefix_fixed<'a, 'b>(line: &'a str, prefix: &'b str) -> &'a str {line}

fn test3(){
    let line = "lang:en=Hello World!";
    let lang = "en";

    let v;{
        let p = format!("lang:{}=", lang);
        v = skip_prefix(line, p.as_str());
    }
    println!("{}", v);
}


fn main() {
    // you can select a few of test items.
    // Though these problems can be found in compile time,
    // just move to what compiler showed on screen to check error. 
}
