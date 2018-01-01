#[macro_use]
extern crate serde_derive;

extern crate serde;
extern crate serde_json;

use std::io::{BufReader,BufWriter};
use std::fs::File;

#[derive(Serialize, Deserialize)]
struct Landmark {
    x: i32,
    y: i32,
    name: String
}

fn main() {
    let file = File::open("landmarks.json").unwrap();
    let reader = BufReader::new(file);
    let landmarks: Vec<Landmark> = serde_json::from_reader(reader).unwrap();
    for landmark in landmarks{
        println!("Landmark name: {}\tPosition: ({},{})",landmark.name,landmark.x,landmark.y);
    }
    let landmark = Landmark {
        x: 67,
        y: 23,
        name: String::from("Academia de Caballería")
    };
    let output = File::create("caballeria.json").unwrap();
    let writer = BufWriter::new(output);
    serde_json::to_writer(writer,&landmark).unwrap();
}
