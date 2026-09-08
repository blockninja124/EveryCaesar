#!/usr/bin/env lua

ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

function encrypt(plaintext, key)
    local result = ""
    for i = 1, #plaintext do
        local c = string.upper(plaintext:sub(i,i))
        local index = string.find(ALPH, c)
        if index == nil then
            result = result..c
        else
            index = index + key
            index = mod(index, 26)
            result = result..ALPH:sub(index, index)
        end
    end
    return result
end

function decrypt(ciphertext, key)
    local result = ""
    for i = 1, #ciphertext do
        local c = string.upper(ciphertext:sub(i,i))
        local index = string.find(ALPH, c)
        if index == nil then
            result = result..c
        else
            index = index - key
            index = mod(index, 26)
            result = result..ALPH:sub(index, index)
        end
    end
    return result
end

function mod(n, m)
    return (((n - 1) % m + m) % m)+1
end

io.write("Enter e/d for encrypt/decrypt: ")
local mode = io.read()
if mode == "e" then
    io.write("Enter plaintext: ")
    local plaintext = io.read()
    io.write("Enter key: ")
    local key = tonumber(io.read())
    print(encrypt(plaintext, key))
end
if mode == "d" then
    io.write("Enter ciphertext: ")
    local ciphertext = io.read()
    io.write("Enter key: ")
    local key = tonumber(io.read())
    print(decrypt(ciphertext, key))
end