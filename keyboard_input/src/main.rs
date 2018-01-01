use std::io;
use std::io::Write;
use std::str::FromStr;
use std::num::ParseIntError;

fn read_input() -> Result<u32,ParseIntError> {
    print!("Dime tu edad: ");
    io::stdout().flush().ok();
    let mut input = String::new();
    io::stdin().read_line(&mut input).ok().expect("Error al leer de teclado");
    let input = input.trim();
    let edad: u32 = u32::from_str(&input)?;
    Ok(edad)
}

fn main() {
    let edad;
    loop {
        if let Ok(e) = read_input(){
            edad = e;
            break;
        }else{
            println!("Introduce un número, por favor");
        }
    }
    let frase = if edad >= 18 {
        "Mayor de edad"
    }else{
        "Menor de edad"
    };
    println!("{}",frase);
}
