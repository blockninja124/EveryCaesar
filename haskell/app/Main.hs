module Main (main) where
import Data.List
import Distribution.Simple.HaskellSuite (getLanguages)

total :: [Int] -> Int
total (x:xs) = x + sum xs

alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
lower_alph = "abcdefghijklmnopqrstuvwxyz"

toindex :: Char -> Int
toindex x = safeindex x (elemIndex x alph)

safeindex :: Char -> Maybe Int -> Int
safeindex c Nothing = defaultindex (elemIndex c lower_alph)
safeindex c (Just x) = x

defaultindex :: Maybe Int -> Int
defaultindex Nothing = 0
defaultindex (Just x) = x

crypt :: (Int -> Int) -> String -> String
crypt k [] = []
crypt k (x:xs) = alph!!(k (toindex x)) : crypt k xs

encrypt :: Int -> String -> String
encrypt k [] = []
encrypt k (xs) = crypt (\x -> (x + k) `mod` 26) xs

decrypt :: Int -> String -> String
decrypt k [] = []
decrypt k (xs) = crypt (\x -> (x - k) `mod` 26) xs

data Input = Encrypt Int String
    | Decrypt Int String
    deriving Show

getinput :: String -> Int -> String -> Input
getinput "d" k s = Decrypt k s
getinput _ k s = Encrypt k s

processinput :: Input -> String
processinput (Encrypt k s) = encrypt k s
processinput (Decrypt k s) = decrypt k s

main :: IO ()
main = do 
    putStrLn "Enter e/d for encrypt/decrypt: "
    m <- getLine
    putStrLn "Enter key: "
    k_s <- getLine
    let k = read k_s :: Int
    putStrLn "Enter plaintext/ciphertext: "
    s <- getLine
    putStrLn (show (processinput (getinput m k s)))
    main

