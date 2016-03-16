module Web.Application (run) where

import           Yesod
import           Web.Router (App(..))

run :: IO ()
run = warp 4242 App
