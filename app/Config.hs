module Config where

import           System.Environment

lookupSetting :: String -> String -> IO String
lookupSetting key def = lookupEnv key >>= \v -> return $ maybe def id v

promptSetting :: String -> IO String
promptSetting key = do
  putStrLn ("Enter default value for: " ++ key)
  value <- getLine
  return value
