module Main where

import           Config

main :: IO ()
main = do
  putStrLn "InstaHuskee 🐕 "

showBogusSettings :: IO ()
showBogusSettings = do
  code <- lookupSetting "IG_CODE" "default-code"
  secret <- lookupSetting "IG_SECRET" "default-secret"
  clientId <- lookupSetting "IG_CLIENT_ID" "default-client-id"
  redirectUri <- lookupSetting "IG_REDIRECT_URI" "https://example.com/auth/ig"
  print $ "Client ID: " ++ clientId
  print $ "Secret: " ++ secret
  print $ "Code: " ++ code
  print $ "Redirect URI: : " ++ redirectUri
  return ()
