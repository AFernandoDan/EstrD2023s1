-- Your previous Markdown content is preserved below:

-- Given a string `s`, find the length of the longest substring that doesn't contain any repeating characters.

-- A "substring that doesn't contain any repeating characters" is a string of SEQUENTIAL characters taken IN ORDER from the original string,
-- where every letter in the substring is unique, (has a count of 1).


-- ### Example 1:

-- Input: `s = "abcabcbdb"`

-- Output: `3`

-- Explanation: The the length is 3, the substring could be `"abc"`.


-- ### Example 2:

-- Input: `s = "bbbbb"`

-- Output: `1`

-- Explanation: The length is 1, the substring would be `"b"`.


-- ### Example 3:

-- Input: `s = "pwwkew"`

-- Output: `3`

-- Explanation: The length is 3, the substring could be `"wke"`.


-- ### Example 4:

-- Input: `s = ""`

-- Output: `0`


-- ### Constraints:
-- - s consists of A-Z, a-z no symbols or any spaces.
-- - empty s should return 0 

-- ---

-- ```

-- Your pseudo-code goes here.


-- ```

-- Solution will run in Haskell Interpreted Mode


substringMasLargo :: String -> String
substringMasLargo [] = []
substringMasLargo (x:xs) = 
  if elem x (substringMasLargo xs)
  then substringMasLargo xs
  else x: substringMasLargo xs

substrings :: String -> [String]
substrings [] = []
substrings (s:ss) = substrings ss


data Tree a = NodeT a (Tree a) (Tree a) | EmptyT

-- el arbol no esta vacio
elMenor :: Ord a => Tree a -> a
elMenor (NodeT x ti (EmptyT)) = x
elMenor (NodeT x ti td) = elMenor td