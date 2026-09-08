use std::io::{self, Read};

const ALPH: &str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

fn main() {
    let mut mode = String::new();

    println!("Enter e/d for encrypt/decrypt: ");
    io::stdin()
        .read_line(&mut mode)
        .expect("Expected a mode");
    let mode = mode.trim();
    
    if mode == "e" {
        println!("Enter plaintext: ");
        let mut plaintext = String::new();
        io::stdin()
            .read_line(&mut plaintext)
            .expect("Expected a plaintext");

        println!("Enter key: ");
        let mut key = String::new();
        io::stdin()
            .read_line(&mut key)
            .expect("Expected a key");
        let key: usize = key.trim().parse().expect("Not a number");

        println!("{}", encrypt(plaintext, key));
    }

    if mode == "d" {
        println!("Enter ciphertext: ");
        let mut ciphertext = String::new();
        io::stdin()
            .read_line(&mut ciphertext)
            .expect("Expected a ciphertext");

        println!("Enter key: ");
        let mut key = String::new();
        io::stdin()
            .read_line(&mut key)
            .expect("Expected a key");
        let key: usize = key.trim().parse().expect("Not a number");

        println!("{}", decrypt(ciphertext, key));
    }
}

fn encrypt(plaintext: String, key: usize) -> String {
    let mut result = String::new();

    for mut c in plaintext.chars() {
        c = c.to_ascii_uppercase();
        let index = ALPH.find(c);
        if (index.is_some()) {
            let mut index = index.unwrap() + key;
            index = index % 25;
            c = ALPH.as_bytes()[index] as char;
        }
        result.push(c);
    }

    result
}

fn decrypt(ciphertext: String, key: usize) -> String {
    let mut result = String::new();

    for mut c in ciphertext.chars() {
        c = c.to_ascii_uppercase();
        let mut index = ALPH.find(c);
        if (index.is_some()) {
            // Use i32 for negative numbers, usize for every other step
            let mut index: i32 = (index.unwrap() as i32) - (key as i32);
            // rem_euclid handles negative modulos, % does weird stuff with negative
            index = index.rem_euclid(25);
            c = ALPH.as_bytes()[index as usize] as char;
        }
        result.push(c);
    }

    result
}