{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Web.Router (
  Widget,
  App(..),
  resourcesApp
  ) where

import           Yesod

data App = App

mkYesod "App" [parseRoutes|
/            HomeR        GET
/auth        AuthR        GET
/dashboard   DashboardR   GET
|]

instance Yesod App

-- Handlers
-- type Handler Html = HandlerT App IO Html

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
