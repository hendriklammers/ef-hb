{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)
import Text.Read (readMaybe)
import Web.Scotty

routes :: ScottyM ()
routes = do
    get "/" $ file "client/index.html"
    notFound $ file "404.html"

main :: IO ()
main = do
    port <- fromMaybe 3000 . (readMaybe =<<) <$> lookupEnv "PORT"
    scotty port routes
