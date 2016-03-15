module Web.Application (run) where

import           Yesod
import           Web.Router (InstaHuskeeWeb(..))

run :: IO ()
run = warp 3000 InstaHuskeeWeb
