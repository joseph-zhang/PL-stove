/*
// three modules, client, network and network::server
// - communicator (library crate)
//  |-- client
//  |-- network
//     |-- server (sub-module of network module)

mod client {
    fn conncet() {
    }
}

mod network {
    fn conncet() {
    }

    mod server() {
        fn connect() {
        }
    }
}
 */

/*
// the line mod client; means that:
 mod client {
  // content of clinet.rs
}
 */

pub mod client;
pub mod network;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
