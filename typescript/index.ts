#!/usr/bin/node
import readline from 'node:readline';

const ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

rl.question(`Enter e/d for encrypt/decrypt: `, (mode: string) => {
    if (mode == "e") {
        rl.question(`Enter plaintext: `, (plaintext: any) => {
            rl.question(`Enter key: `, (key: string) => {
                console.log(encrypt(plaintext, parseInt(key)));
                rl.close();
            });
        });
    }

    if (mode == "d") {
        rl.question(`Enter ciphertext: `, (ciphertext: any) => {
            rl.question(`Enter key: `, (key: string) => {
                console.log(decrypt(ciphertext, parseInt(key)));
                rl.close();
            });
        });
    }
});

function encrypt(plaintext: string, key: number) {
    let result = "";
    for (let i = 0; i < plaintext.length; i++) {
        let c = plaintext.charAt(i).toUpperCase();
        let index = ALPH.indexOf(c);
        if (index == -1) {
            result += c;
        } else {
            index = index + key;
            index = index % 26;
            result += ALPH[index];
        }
    }
    return result;
}

function decrypt(ciphertext: string, key: number) {
    let result = "";
    for (let i = 0; i < ciphertext.length; i++) {
        let c = ciphertext.charAt(i).toUpperCase();
        let index = ALPH.indexOf(c);
        if (index == -1) {
            result += c;
        } else {
            index = index - key;
            index = mod(index, 26);
            result += ALPH[index];
        }
    }
    return result;
}

// Handles negative numbers better than %
// but is slower
function mod(n: number, m: number) {
  return ((n % m) + m) % m;
}
