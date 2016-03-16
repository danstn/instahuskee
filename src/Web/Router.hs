{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Web.Router (
  App(..),
  resourcesApp
  ) where

import           Data.Text
import           Yesod
import           InstaHuskee as IH

type AuthUrl = Text

-- Yesod App Foundation
--------------------------------------------------------------------------------
data App = App

mkYesod "App" [parseRoutes|
/                HomeR        GET
/auth            AuthR        GET
/auth/instagram  RedirectR    GET
/dashboard       DashboardR   GET
|]

instance Yesod App


-- Handlers
-- type GHandler m a = HandlerT App m a
-- type Handler a    = HandlerT App IO a
-- type Handler Html = HandlerT App IO Html
--------------------------------------------------------------------------------
getHomeR :: Handler Html
getHomeR = defaultLayout homeTemplate

getAuthR :: Handler Html
getAuthR = do
  authUrl <- liftIO $ IH.getAuthURL
  defaultLayout $ authTemplate authUrl

getDashboardR :: Handler Html
getDashboardR = defaultLayout dashboardTemplate

getRedirectR :: Handler Html
getRedirectR = do
  code <- lookupGetParam "code"
  case code of
    Just c -> do
      token <- liftIO $ IH.getAuthToken c
      defaultLayout igAuthOkTemplate
    Nothing -> do
      defaultLayout igAuthFailTemplate

-- Templates (pull out into separate hamlet files!)
--------------------------------------------------------------------------------

homeTemplate :: Widget
homeTemplate = do
  setTitle "Root"
  toWidget [whamlet|
           Routes:
           <a href=@{AuthR}>Authentication
           <a href=@{DashboardR}>Dashboard
  |]

authTemplate :: AuthUrl -> Widget
authTemplate authUrl = do
  setTitle "Authentication"
  toWidget [whamlet|
           <a href="#{authUrl}">Authenticate me!
  |]

dashboardTemplate :: Widget
dashboardTemplate = do
  setTitle "Dashboard"
  toWidget[whamlet|
          Dashboard
  |]

igAuthOkTemplate :: Widget
igAuthOkTemplate = do
  setTitle "Auth Success!"
  toWidget[whamlet|You are successfully authenticated!|]

igAuthFailTemplate :: Widget
igAuthFailTemplate = do
  setTitle "Auth Failure..."
  toWidget[whamlet|Authentication failed. Check logs for details.!|]

