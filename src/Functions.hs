module Functions where
  import System.Directory
  -- gets default directory (C:/users/test)
  homeDir :: IO String
  homeDir = do
    dir <- getHomeDirectory
    return dir

  -- used to get user input
  getInput :: String -> IO String
  getInput input = do

    putStr (input)
    getLine

  -- Reads contents of the file
  readTheFile  :: String -> IO String
  readTheFile read = do
    readFile read

  --takes the file and returns a list seperated by line
  contentsToList :: String -> [String]
  contentsToList output = lines output

  --Obsolete - should probably remove and refactor existing usage
  incrementIndex :: Int ->Int
  incrementIndex index = index+1

  --Function takes line and returns list of each word
  parseByLine :: String -> [String]
  parseByLine line = words line

  
