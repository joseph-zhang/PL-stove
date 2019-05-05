extern crate communicator;

fn main() {
    communicator::client::connect();
    communicator::network::server::connect();


    // communicator::network::connect() is private
    //communicator::network::connect();
}
