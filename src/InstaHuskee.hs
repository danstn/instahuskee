{-# LANGUAGE FlexibleContexts #-}

module InstaHuskee where

import           Data.Text
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS (tlsManagerSettings)
import           Control.Monad.Trans.Resource
import           Control.Monad.IO.Class
import           Instagram

-- To be parametrised/read from the environment

code :: Text
code = pack "YOUR_CODE"

redirectUri :: RedirectUri
redirectUri = pack "http://example.com/auth/ig"

credentials :: Credentials
credentials = Credentials (pack "CLIENT_ID") (pack "CLIENT_SECRET")

-- Authenticated actions --

getAuthToken :: IO OAuthToken
getAuthToken = runIGAction $ getUserAccessTokenURL2 redirectUri code

-- Mechanics --

runIGAction :: InstagramT (ResourceT IO) a -> IO a
runIGAction = runResourceT . runInstagramFn

runInstagramFn :: forall b (m :: * -> *) . (MonadBaseControl IO m, MonadResource m) => InstagramT m b -> m b
runInstagramFn igAction = do
  manager <- liftIO $ newManager tlsManagerSettings
  runInstagramT credentials manager igAction
