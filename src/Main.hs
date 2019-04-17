{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Maybe (fromMaybe)
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment (lookupEnv)
import Text.Read (readMaybe)
import Web.Scotty

routes :: ScottyM ()
routes =
    get "/" $ file "./frontend/dist/index.html"

main :: IO ()
main = do
    port <- fromMaybe 3000 . (readMaybe =<<) <$> lookupEnv "PORT"
    scotty port $ do
        middleware logStdoutDev
        middleware $ staticPolicy (noDots >-> addBase "./frontend/dist")
        routes
