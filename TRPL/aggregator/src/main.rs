extern crate aggregator;
use aggregator::Summarizable;


struct WeatherForecast{
    high_temp: f64,
    low_temp: f64,
    chance_of_precipitation: f64,
}

impl Summarizable for WeatherForecast{
    fn summary(&self) -> String{
        format!("The high will be {htemp}, and the low will be {ltemp}. The chance of precipitation is {perc}%.",
                htemp = self.high_temp,
                ltemp = self.low_temp,
                perc = self.chance_of_precipitation)
    }
}
    
fn main(){
    let tweet = aggregator::Tweet{
        username: String::from("horse_ebooks"),
        content: String::from("of course, as you probably already know, people"),
        reply: false,
        retweet: false,
    };
    println!("1 new tweet: {}", tweet.summary());

    let weather = WeatherForecast{
        high_temp: 35.,
        low_temp: 26.,
        chance_of_precipitation: 65
    };
    println!("new weather info: {}", weather.summary());
}
