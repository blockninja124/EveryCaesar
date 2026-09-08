import java.util.Scanner;

public class Main {
    public static final String ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    public static void main(String[] args) {
        System.out.println("Enter e/d for encrypt/decrypt: ");
        
        Scanner sc = new Scanner(System.in);
        String mode = sc.nextLine().trim();
        
        if (mode.equals("e")) {
            System.out.println("Enter plaintext: ");
            String plaintext = sc.nextLine();

            System.out.println("Enter key: ");
            int key = sc.nextInt();

            System.out.println(encrypt(plaintext, key));
        }

        if (mode.equals("d")) {
            System.out.println("Enter ciphertext: ");
            String ciphertext = sc.nextLine();

            System.out.println("Enter key: ");
            int key = sc.nextInt();

            System.out.println(decrypt(ciphertext, key));
        }

        sc.close();
    }

    public static String encrypt(String plaintext, int key) {
        String result = "";

        for (int i = 0; i < plaintext.length(); i++){
            char c = Character.toUpperCase(plaintext.charAt(i));        
            int index = ALPH.indexOf(c);
            if (index == -1) {
                result += c;
            } else {
                index = index + key;
                index = index % 26;
                result += ALPH.charAt(index);
            }
        }

        return result;
    }

    public static String decrypt(String ciphertext, int key) {
        String result = "";

        for (int i = 0; i < ciphertext.length(); i++){
            char c = ciphertext.charAt(i);        
            int index = ALPH.indexOf(c);
            if (index == -1) {
                result += c;
            } else {
                index = index - key;
                index = mod(index, 26);
                result += ALPH.charAt(index);
            }
        }

        return result;
    }

    /**
     * Better than % at negative numbers, but slower
     */
    private static int mod(int n, int m) {
        return (n % m + m) % m;
    }
}