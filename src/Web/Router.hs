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
getHomeR = defaultLayout $ do
  setTitle "Root"
  toWidget [whamlet|
           Routes:
           <a href=@{AuthR}>Authentication
           <a href=@{DashboardR}>Dashboard
  |]

getAuthR :: Handler Html
getAuthR = defaultLayout $ do
  setTitle "Authentication"
  toWidget [whamlet|
           <a href="#">Authenticate me!
  |]

getDashboardR :: Handler Html
getDashboardR = defaultLayout $ do
  setTitle "Dashboard"
  toWidget[whamlet|
          Dashboard
  |]
