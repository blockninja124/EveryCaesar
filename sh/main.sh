#!/bin/sh

ALPH="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

encrypt() {
	plaintext="$1"
    key="$2"

    result=""

    i=0
    len=${#plaintext}
    while [ "$i" -lt "$len" ]; do
        char=$(printf '%s' "$plaintext" | cut -c $((i + 1)))
        upper=$(printf '%s' "$char" | tr '[:lower:]' '[:upper:]')

        prefix=${ALPH%%"$upper"*}
        if [ "$prefix" = "$ALPH" ]; then
            idx=-1
        else
            idx=${#prefix}
        fi

        if [ "$idx" = -1 ]; then
            result="$result$char"
        else
            idx=$(((idx + key) % 26))
            newchar=$(printf '%s' "$ALPH" | cut -c $((idx + 1)))
            result="$result$newchar"
        fi

        i=$((i + 1))
    done

    echo "$result"
}

decrypt() {
	ciphertext="$1"
    key="$2"

    result=""

    i=0
    len=${#ciphertext}
    while [ "$i" -lt "$len" ]; do
        char=$(printf '%s' "$ciphertext" | cut -c $((i + 1)))
        upper=$(printf '%s' "$char" | tr '[:lower:]' '[:upper:]')

        prefix=${ALPH%%"$upper"*}
        if [ "$prefix" = "$ALPH" ]; then
            idx=-1
        else
            idx=${#prefix}
        fi

        if [ "$idx" = -1 ]; then
            result="$result$char"
        else
            idx=$(((idx - key % 26 + 26) % 26))
            newchar=$(printf '%s' "$ALPH" | cut -c $((idx + 1)))
            result="$result$newchar"
        fi

        i=$((i + 1))
    done

    echo "$result"
}

printf 'Enter e/d for encrypt/decrypt: '
read mode

if [ "$mode" = "e" ]; then
    printf 'Enter plaintext: '
    read plaintext
    printf 'Enter key: '
    read key
    message=$(encrypt "$plaintext" "$key")
    echo "$message"
fi

if [ "$mode" = "d" ]; then
    printf 'Enter ciphertext: '
    read ciphertext
    printf 'Enter key: '
    read key
    message=$(decrypt "$ciphertext" "$key")
    echo "$message"
fi