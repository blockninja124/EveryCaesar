class Main {
    static final String ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    static void main(String[] args) {
        println("Enter e/d for encrypt/decrypt: ")

        Scanner sc = new Scanner(System.in)
        String mode = sc.nextLine().trim()

        if (mode == "e") {
            println("Enter plaintext: ")
            String plaintext = sc.nextLine()

            println("Enter key: ")
            int key = sc.nextInt()

            println(encrypt(plaintext, key))
        }

        if (mode == "d") {
            println("Enter ciphertext: ")
            String ciphertext = sc.nextLine()

            println("Enter key: ")
            int key = sc.nextInt()

            println(decrypt(ciphertext, key))
        }

        sc.close()
    }

    static String encrypt(String plaintext, int key) {
        String result = ""

        for (int i = 0; i < plaintext.length(); i++){
            char c = Character.toUpperCase(plaintext.charAt(i))
            int index = ALPH.indexOf(c as int)
            if (index == -1) {
                result += c
            } else {
                index = index + key
                index = index % 26
                result += ALPH.charAt(index)
            }
        }

        return result
    }

    static String decrypt(String ciphertext, int key) {
        String result = ""

        for (int i = 0; i < ciphertext.length(); i++){
            char c = Character.toUpperCase(ciphertext.charAt(i))
            int index = ALPH.indexOf(c as int)
            if (index == -1) {
                result += c
            } else {
                index = index - key
                index = mod(index, 26)
                result += ALPH.charAt(index)
            }
        }

        return result
    }

    /**
     * Better than % at negative numbers, but slower
     */
    static int mod(int n, int m) {
        return (n % m + m) % m
    }
}
