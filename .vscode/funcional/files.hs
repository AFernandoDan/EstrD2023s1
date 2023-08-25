import Control.Exception (PatternMatchFail(PatternMatchFail))
type Name = String
type Content = String
type Path = [Name]
data FileSystem = File Name Content | Folder Name [FileSystem]

foldFs :: (Name -> Content -> b) -> (Name -> c -> b) -> ([b] -> c) -> FileSystem -> b
foldFs f gx gt (File name content) = f name content
foldFs f gx gt (Folder name fs)= gx name (gt (map (foldFs f gx gt) fs)) 


amountOfFiles :: FileSystem -> Int
amountOfFiles = foldFs (\x cs-> 1) (\name-> id) (sum)

find :: Name -> FileSystem -> Maybe Content
find n = foldFs (\name cont -> if n == name then Just cont else Nothing ) (\name->id) (\mbs -> head (filter (/= Nothing) mbs))


-- crea un file system con 2 carpetas y 3 archivos  
fs :: FileSystem
fs = Folder "root" [Folder "folder1" [File "file3" "content3"],File "file1" "content1", File "file2" "content2" ]

pathOf :: Name -> FileSystem -> Path
pathOf n= foldFs (const) (\name r -> name : r) (\pts -> filter (==n) pts)

pathOf2 :: Name -> FileSystem -> Path 
pathOf2 n (File name _) = if n == name then [name] else []
pathOf2 n (Folder name fs) = if n == name then [name] else name : (filter (/= []) (map (pathOf2 n) fs))

map2 :: (a->b) -> [a] -> [b]
map2 f [] = []
map2 f (x:xs) = f x : (map2 f xs)

nameOf :: FileSystem -> Name
nameOf (Folder name _) = name 
nameOf (File name _) = name