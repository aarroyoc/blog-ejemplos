extern crate bindgen;

use std::env;
use std::path::PathBuf;

fn main() {
    // indicamos al linker que necesitamos sqlite3
    println!("cargo:rustc-link-lib=sqlite3");


    let bindings = bindgen::Builder::default()
        .header("wrapper.h")
        .generate()
        .expect("Unable to generate bindings");

    // escribir los bindings en $OUT_DIR/bindings.rs
    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
    bindings
        .write_to_file(out_path.join("bindings.rs"))
        .expect("Couldn't write bindings!");
}