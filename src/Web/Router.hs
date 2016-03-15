{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Web.Router (
  InstaHuskeeWeb(..)
  ) where

import           Yesod

data InstaHuskeeWeb = InstaHuskeeWeb

mkYesod "InstaHuskeeWeb" [parseRoutes|
/            HomeR        GET
/auth        AuthR        GET
/dashboard   DashboardR   GET
|]

instance Yesod InstaHuskeeWeb

-- Handlers
-- type Handler Html = HandlerT InstaHuskeeWeb IO Html

getHomeR :: Handler Html
getHomeR =
  defaultLayout [whamlet|
                Routes:
                <a href=@{AuthR}>Authenticate
                <a href=@{DashboardR}>Dashboard
  |]

getAuthR :: Handler Html
getAuthR = defaultLayout [whamlet|
                         Authenticating...
  |]

getDashboardR :: Handler Html
getDashboardR = defaultLayout [whamlet|
                              Dashboard
  |]
