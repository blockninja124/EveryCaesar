import java.util.*

const val ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

fun main() {
    println("Enter e/d for encrypt/decrypt: ")
        
    val sc = Scanner(System.`in`)
    val mode = sc.nextLine().trim()

    if (mode == "e") {
        println("Enter plaintext: ")
        val plaintext = sc.nextLine()

        println("Enter key: ")
        val key = sc.nextInt()

        println(encrypt(plaintext, key))
    }

    if (mode == "d") {
        println("Enter ciphertext: ")
        val ciphertext = sc.nextLine()

        println("Enter key: ")
        val key = sc.nextInt()

        println(decrypt(ciphertext, key))
    }

    sc.close()
}

fun encrypt(plaintext: String, key: Int): String {
    var result = ""

    for (i in 0..<plaintext.length) {
        val c = Character.toUpperCase(plaintext[i])
        var index = ALPH.indexOf(c)
        if (index == -1) {
            result += c
        } else {
            index += key
            index %= 26
            result += ALPH[index]
        }
    }

    return result;
}

fun decrypt(ciphertext: String, key: Int): String {
    var result = ""

    for (i in 0..<ciphertext.length) {
        val c = Character.toUpperCase(ciphertext[i])
        var index = ALPH.indexOf(c)
        if (index == -1) {
            result += c
        } else {
            index -= key
            index = mod(index, 26)
            result += ALPH[index]
        }
    }

    return result
}

/**
 * Better than % at negative numbers, but slower
 */
private fun mod(n: Int, m: Int): Int {
    return (n % m + m) % m
}
