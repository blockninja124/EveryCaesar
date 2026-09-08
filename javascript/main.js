#!/usr/bin/node
const readline = require('node:readline');

const ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

rl.question(`Enter e/d for encrypt/decrypt: `, mode => {
    if (mode == "e") {
        rl.question(`Enter plaintext: `, plaintext => {
            rl.question(`Enter key: `, key => {
                console.log(encrypt(plaintext, parseInt(key)));
                rl.close();
            });
        });
    }

    if (mode == "d") {
        rl.question(`Enter ciphertext: `, ciphertext => {
            rl.question(`Enter key: `, key => {
                console.log(decrypt(ciphertext, parseInt(key)));
                rl.close();
            });
        });
    }
});

function encrypt(plaintext, key) {
    let result = "";
    for (let i = 0; i < plaintext.length; i++) {
        let c = plaintext.charAt(i).toUpperCase();
        let index = ALPH.indexOf(c);
        if (index == -1) {
            result += c;
        } else {
            index = index + key;
            index = index % 25;
            result += ALPH[index];
        }
    }
    return result;
}

function decrypt(ciphertext, key) {
    let result = "";
    for (let i = 0; i < ciphertext.length; i++) {
        let c = ciphertext.charAt(i).toUpperCase();
        let index = ALPH.indexOf(c);
        if (index == -1) {
            result += c;
        } else {
            index = index - key;
            index = mod(index, 25);
            result += ALPH[index];
        }
    }
    return result;
}

// Handles negative numbers better than %
// but is slower
function mod(n, m) {
  return ((n % m) + m) % m;
}
