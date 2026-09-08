#!/usr/bin/python3
ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

def encrypt(plaintext: str, key: int) -> str:
    result = ""
    for letter in plaintext:
        if letter.upper() in ALPH:
            index = (ALPH.index(letter.upper()) + key) % 26
            result += ALPH[index]
        else:
            result += letter
    return result

def decrypt(ciphertext: str, key: int) -> str:
    result = ""
    for letter in ciphertext:
        if letter.upper() in ALPH:
            index = (ALPH.index(letter.upper()) - key) % 26
            result += ALPH[index]
        else:
            result += letter
    return result

if __name__ == "__main__":
    mode = input("Enter e/d for encrypt/decrypt: ")
    if mode == "e":
        plaintext = input("Enter plaintext: ")
        key = int(input("Enter key: "))
        print(encrypt(plaintext, key))
    if mode == "d":
        ciphertext = input("Enter ciphertext: ")
        key = int(input("Enter key: "))
        print(decrypt(ciphertext, key))