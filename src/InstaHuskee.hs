{-# LANGUAGE FlexibleContexts #-}

module InstaHuskee where

import           Data.Text
import           Data.Default (def)

import           Network.HTTP.Client
import           Network.HTTP.Client.TLS (tlsManagerSettings)

import           Control.Monad.Reader
import           Control.Monad.Trans.Resource

import           Instagram

--------------------------------------------------------------------------------

type Config = String
type AppM a = InstagramT (ResourceT IO) a

--------------------------------------------------------------------------------

runApp :: (MonadReader Config m, MonadIO m) => AppM a -> m a
runApp = undefined

-- To be parametrised/read from the environment

code :: Text
code = pack "YOUR_CODE"

redirectUri :: RedirectUri
redirectUri = pack "http://example.com/auth/ig"

credentials :: Credentials
credentials = Credentials (pack "CLIENT_ID") (pack "CLIENT_SECRET")

-- Authenticated actions --

getRecentMediaByTag :: Text -> OAuthToken -> IO (Envelope [Media])
getRecentMediaByTag tag token = runIGAction $ getRecentTagged tag (Just token) def

getAuthURL :: IO Text
getAuthURL = runIGAction $ getUserAccessTokenURL1 redirectUri []

getAuthToken :: IO OAuthToken
getAuthToken = runIGAction $ getUserAccessTokenURL2 redirectUri code

-- Mechanics --

runIGAction :: AppM a -> IO a
runIGAction = runResourceT . runInstagramFn

runInstagramFn :: forall b (m :: * -> *) . (MonadBaseControl IO m, MonadResource m) => InstagramT m b -> m b
runInstagramFn igAction = do
  manager <- liftIO $ newManager tlsManagerSettings
  runInstagramT credentials manager igAction
