--Non-Concurrent Haskell
module Main where
import System.Directory
import System.FilePath
import qualified Data.Text as Txt
import Data.List
import Functions

type ColumnNumber = Int
type LineNumber = Int
type PositionNumber = Int
data Positions = Positions ColumnNumber LineNumber PositionNumber

checkWordRewrite :: Positions -> [String] -> String -> String -> IO()
checkWordRewrite _ [] _ _= return()

checkWordRewrite (Positions column line pos) (x:xs) searchTerm fullLine =

  if (x == searchTerm)
    then do

      putStrLn ("Search Term " ++ searchTerm ++ " found in position: " ++ show (pos) ++ " And on line " ++ show(line))  --print result
      print(fullLine) -- Prints the whole line
      putStrLn ""
      checkWordRewrite (Positions column (line) (pos+1)) xs searchTerm fullLine
    else
      checkWordRewrite (Positions column (line) (pos+1)) xs searchTerm fullLine-- Increment Anyway


getTheLine :: String -> [String] -> Int -> IO ()
getTheLine _ [] _ = return() --When all lines have been read
getTheLine searchTerm (x:xs) line = do

  -- Seperates each line into a list of words


  checkWordRewrite (Positions 1 (line+1) 1) (words x) searchTerm x

  getTheLine searchTerm xs (line+1)
  
  return ()

getFileFromList :: [String] -> String -> String -> IO String
getFileFromList [] _ _ = return("")
getFileFromList (x:xs) dir searchTerm = do

  let currentFile = x -- get a file - done sequentially

  let fullSearchTerm = dir ++ "\\" ++ currentFile --Full path to the file

  output <-  readTheFile fullSearchTerm --reads the contents of the file

  putStrLn ("Now searching " ++ currentFile ++ " For " ++ searchTerm)

  getTheLine searchTerm (contentsToList output) 0 -- passes the list to be processed - rest done using recursion

  getFileFromList xs dir searchTerm-- Get the next file

  return ""


main :: IO ()
main = do
    dir <- homeDir

    choice <- getInput "By default, this program reads files from your home directory. Enter 'y' to specify a custom path. Otherwise, press enter to continue."

    if choice == "y"
      then do
        dir <- getInput "Please enter a directory (C:/Users/test)"
        putStrLn ""
      else
        return ()

    searchTerm <- getInput "Please enter a phrase to search for:"
    putStrLn ""

    allFiles <- listDirectory dir -- Get all the files in a certain directory

    let filtered = filter (isSuffixOf ".txt") allFiles -- only files that end in .txt
    getFileFromList filtered dir searchTerm
    return()
